import 'package:flutter/material.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:provider/provider.dart';
import 'StateManagement/UserProvider.dart';
import 'model/UserProfileModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    UserProfileModel _udata = userProvider.profile();

    return userProvider.isLoading == false
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 0,
              title: Text('Profile'),
              centerTitle: true,
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Card(
                      elevation: 5,
                      shape: CircleBorder(),
                      child: ClipOval(
                        // backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: _udata.profilePic,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/user.png',
                            height: MediaQuery.of(context).size.width * 0.35,
                            width: MediaQuery.of(context).size.width * 0.35,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: MediaQuery.of(context).size.width * 0.35,
                          width: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                       
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: new Text(
                                'Personal Information',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: (fullLabel("Name")),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              decoration: InputDecoration(
                                  hintText: _udata.name, enabled: false),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: (fullLabel("Email")),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              decoration: InputDecoration(
                                  hintText: _udata.email, enabled: false),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: (fullLabel("Contact No.")),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              decoration: InputDecoration(
                                  hintText: _udata.contactNo, enabled: false),
                            ),
                          ),
                        ],
                      )),
            
                ],
              ),
            ))
        : Scaffold(
            body: Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader4,
              color: Colors.green,
            )),
          );
  }

  Widget fullLabel(String title) {
    return Builder(builder: (BuildContext mContext) {
      return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
