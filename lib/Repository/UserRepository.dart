import 'dart:convert';
import '../Api/api.dart';
import '../Model/customer_login.dart';
import '../Utils/preferences.dart';
import '../Utils/util_preferences.dart';



class UserRepository {

  ///Fetch api login
  Future<dynamic> login({String? email,String? password}) async {
    final params = {"user_email":email,"password":password};
    return await Api.login(params);
  }
  Future<dynamic> fetchProduct({String? perPage, String? startFrom}) async {
    final params = {"per_page":perPage,
      "start_from":startFrom};
    return await Api.getProduct(params);
  }

  Future<dynamic> fetchProductCategory({String? ssCatId}) async {
    final params = {"sscat_id":ssCatId};
    return await Api.getCategoryProduct(params);
  }

  //Fetch User Profile
  Future<dynamic> fetchUserProfile({String? user_id}) async {
    final params = {"user_id":user_id,};
    return await Api.userProfile(params);
  }

  //Contact Us api
  Future<dynamic> contactUs({String? name,String? email,String? mobileNo,String? message}) async {
    final params = {"name":name, "email":email,"mobile_no":mobileNo,"message": message};
    return await Api.contactUs(params);
  }

  ///Save Storage
  Future<dynamic> saveUser(CustomerLogin user) async {
    return await UtilPreferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  ///Get Product
  Future<dynamic> fetchHomeProduct({String? limit}) async {
    final params = {"limit":limit};
    return await Api.getHomeProduct(params);
  }

  ///Get Banner
  Future<dynamic> fetchHomeBanner() async {
    return await Api.getHomeBanner();
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

