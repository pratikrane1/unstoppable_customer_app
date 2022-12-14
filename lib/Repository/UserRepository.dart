import 'dart:convert';
import '../Api/api.dart';
import '../Model/vendor_login.dart';
import '../Utils/preferences.dart';
import '../Utils/util_preferences.dart';



class UserRepository {

  ///Fetch api login
  Future<dynamic> login({String? email,String? password}) async {
    final params = {"user_email":email,"password":password};
    return await Api.login(params);
  }


  ///Save Storage
  Future<dynamic> saveUser(VendorLogin user) async {
    return await UtilPreferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }


  // //save image
  // Future<dynamic> saveImage(String image) async {
  //   return await UtilPreferences.setString(
  //     Preferences.profilePic,image);
  // }
  //
  //


  ///Get from Storage
  dynamic getUser() {
    return UtilPreferences.getString(Preferences.user);
  }

  // dynamic getProfile() {
  //   return UtilPreferences.getString(Preferences.profilePic);
  // }



  ///Delete Storage
  Future<dynamic> deleteUser() async {
    return await UtilPreferences.remove(Preferences.user);
  }


}

