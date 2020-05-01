import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashboard.dart';

class Uploadpic extends StatefulWidget {
  @override
  _UploadpicState createState() => _UploadpicState();
}

class _UploadpicState extends State<Uploadpic> {
  String gender = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _radioValue = 3; // no choice

  String error = '';
  bool emailexist = false;
  bool isLoading = false;

  File _image;

  Future getImage() async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: ImgSource.Both,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ),
    );
    setState(() {
      _image = image;
    });
  }

  Dio _dio = new Dio();

  Future<String> crateProfile() async {
    setState(() {
      isLoading = true;
    });
    FormData formData = new FormData.fromMap({
      "image": base64Encode(_image.readAsBytesSync()),
      "name": _image.path.split("/").last,
    });

    try {
      var response = await _dio.post(
        "http://oxyindia.com/myoxyapp/uploadimage.php",
        data: formData,
        onSendProgress: (int sent, int total) {
          print(sent / total);
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);

        print(responseBody['status']);
        return responseBody['status'];
      } else {
        print('no response');
        return 'not updated';
      }
    } catch (e) {
      print(e);
      return 'not updated';
    }
  }

  String formattedDate = '';
  @override
  void initState() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    print(formatted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: isLoading == false
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  /*   Center(
                      child: Image.asset(
                    'logo',
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                  )), */
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Uploadpic Here',
                    style: TextStyle(fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        Card(
                          elevation: 2,
                          shape: CircleBorder(),
                          child: ClipOval(
                              child: _image == null
                                  ? Image.asset(
                                      'assets/images/user.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      _image,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        Positioned(
                          top: 80,
                          left: 70,
                          child: InkWell(
                            onTap: getImage,
                            child: Card(
                                color: Colors.white,
                                elevation: 10,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.pink,
                                  size: 30,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          onTap: () {
                            crateProfile();
                          },
                          child: Card(
                            elevation: 8,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.green),
                                textScaleFactor: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          : Center(
              child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader4,
              color: Colors.green,
            )),
    );
  }
}
