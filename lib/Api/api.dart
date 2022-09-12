import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/vendor_login.dart';


class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  //static const String HOST_URL="https://unstoppabletrade.in/App_details/";
  static const String HOST_URL="http://unstoppabletrade.ezii.live/App_details/";
  static const String VENDOR_LOGIN="app_login";



  ///Login api
  static Future<dynamic> login(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+VENDOR_LOGIN),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return VendorLoginResp.fromJson(responseJson);
    }
  }


}