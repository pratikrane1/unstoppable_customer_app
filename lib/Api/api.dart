import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/contact_us_model.dart';
import '../Model/customer_login.dart';
import '../Model/user_profile_model.dart';



class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  //static const String HOST_URL="https://unstoppabletrade.in/App_details/";
  static const String HOST_URL="https://unstoppabletrade.in/customer_app/";
  static const String CUSTOMER_LOGIN="app_login";
  static const String CUSTOMER_REGISTER="register_customer";
  static const String CUSTOMER_PROFILE_UPDATE=HOST_URL+"update_profile";
  static const String CONTACT_US="contact_us";
  static const String GET_PROFILE="get_profile";



  ///Login api
  static Future<dynamic> login(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CUSTOMER_LOGIN),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CustomerLoginRepo.fromJson(responseJson);
    }
  }


  //User Profile
  static Future<dynamic> userProfile(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+GET_PROFILE),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return UserProfile.fromJson(responseJson);
    }
  }

  ///Contact Us
  static Future<dynamic> contactUs(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CONTACT_US),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ContactUsRepo.fromJson(responseJson);
    }
  }


}