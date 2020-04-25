import 'Dashboard.dart';
import 'Login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'StateManagement/UserProvider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.green));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            appBarTheme: AppBarTheme(
              color: Colors.green,
            )),
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<bool> saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('email') != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    saveEmail().then((res) {
      if (res == true) {
        Timer(
            Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Dashboard())));
      } else {
        Timer(
            Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Login())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Center(
              child: Image.asset(
            'assets/images/user.png',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
          )),
          SizedBox(
            height: 50,
          ),
          Center(child: Text('Splash'))
        ],
      ),
    );
  }
}
