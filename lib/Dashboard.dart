import 'package:authentication/Profile.dart';
import 'main.dart';
import 'model/UserProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'StateManagement/UserProvider.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    UserProfileModel _udata = userProvider.profile();

    return userProvider.isLoading == false
        ? Container(
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                actions: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile()));
                    },
                    child: Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20)
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.green),
                      accountName: Text(
                        _udata.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        _udata.email,
                        style: TextStyle(color: Colors.white60),
                      ),
                      currentAccountPicture: Card(
                        shape: CircleBorder(),
                        elevation: 8,
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
                    ListTile(
                      title: Text('Home'),
                      trailing: Icon(Icons.home),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Privacy Policy'),
                      trailing: Icon(Icons.report),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Logout'),
                      trailing: Icon(Icons.highlight_off),
                      onTap: () {
                        logout().then((onValue) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp()));
                        });
                      },
                    ),
                  ],
                ),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Container(
                        child: Text('Dashboard',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader4,
              color: Colors.green,
            )),
          );
  }
}

