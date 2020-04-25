import 'Signup.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Dashboard.dart';
import 'package:awesome_loader/awesome_loader.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  Dio _dio = new Dio();
  bool isloading = false;
  String error;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool checkValidation() {
    if (_email.text != "" && _password.text != "") {
      return true;
    } else {
      error = 'All fields required';
      return false;
    }
  }

  Future<String> login() async {
    setState(() {
      isloading = true;
    });
    FormData formData = new FormData.fromMap({
      "email": _email.text,
      "password": _password.text,
    });

    try {
      var response = await _dio.post(
        "https://yourdomain/applogin.php",
        data: formData,
        onSendProgress: (int sent, int total) {
          print(sent / total);
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);

        return responseBody['email'];
      } else {
        print('no response');
        return 'not updated';
      }
    } catch (e) {
      print(e);
      return 'not updated';
    }
  }

  Future<String> saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _email.text);

    if (prefs.getString('email') != null) {
      return prefs.getString('email');
    } else {
      return 'no email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: isloading == false
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Image.asset(
                      'assets/images/user.png',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _email,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Color(0xfff2f5f3),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _password,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Color(0xfff2f5f3),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Forgot Password',
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 30,
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
                              if (checkValidation() == false) {
                                print(error);
                              } else {
                                login().then((res) {
                                  if (res == _email.text) {
                                    print('yes');
                                    /* setState(() {
                              isloading = false;
                            }); */
                                    saveEmail().then((email) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Dashboard()));
                                    });
                                  } else if (res == 'noEmail') {
                                    setState(() {
                                      //   emailexist = true;
                                      isloading = false;
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Wrong Credentials.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        /*  action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ), */
                                      );

                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                    });
                                  } else {
                                    print('error');
                                    setState(() {
                                      isloading = false;
                                    });
                                     final snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Some Error Occured.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        /*  action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ), */
                                      );

                                      _scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                  }
                                });
                              }
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
                                  'Login',
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
                    Column(
                      children: <Widget>[
                        Text('Do not have a account ? ',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              'Signup Here.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader4,
                color: Colors.green,
              )));
  }
}
