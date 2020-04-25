import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../model/UserProfileModel.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
 
    getProfile();
  }
  Dio dio = new Dio();

  bool isLoading = false;
  getisLoading() => isLoading;
  setisLoadingTrue() => isLoading = true;

  UserProfileModel _udata;

 profile() => _udata;

  getProfile() async {
 
  isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('email') != null) {
      {
        var url = 'https://yourdomain/getuserdata.php';

        FormData _formdata = new FormData.fromMap({
          'email': prefs.getString('email'),
        });

        var response = await dio.post(url, data: _formdata);

        if (response.statusCode == 200) {
          var body = json.decode(response.data);

          if (body.length == 0) {
            return null;
          } else if (body.length == 1) {
            for (var items in body) {
              _udata = UserProfileModel.fromJson(items);
            }
         
           isLoading = false;
            notifyListeners();
          }
        }
      }
    }
  }
}
