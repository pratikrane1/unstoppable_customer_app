import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/category_list.dart';
import '../Model/customer_login.dart';



class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  //static const String HOST_URL="https://unstoppabletrade.in/App_details/";
  static const String HOST_URL="https://unstoppabletrade.in/customer_app/";
  static const String CUSTOMER_LOGIN="app_login";
  static const String CUSTOMER_REGISTER="register_customer";
  static const String CUSTOMER_PROFILE_UPDATE=HOST_URL+"update_profile";
  static const String CHANGE_PASS=HOST_URL+"change_password";
  static const String Category = HOST_URL+"category_list";


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

  ///Register api
  static Future<dynamic> getProduct() async {
    final response = await http.post(
      Uri.parse(Category),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CategoryRepo.fromJson(responseJson);
    }
  }


}