import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/address_model.dart';
import '../Model/banner_model.dart';
import '../Model/category_list.dart';
import '../Model/category_product_model.dart';
import '../Model/contact_us_model.dart';
import '../Model/customer_login.dart';
import '../Model/product_model.dart';
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

  static const String CHANGE_PASS=HOST_URL+"change_password";
  static const String CATEGORIES = HOST_URL+"categories";
  static const String CATEGORY_PRODUCT = HOST_URL+"category_products";
  static const String GET_PRODUCT = HOST_URL+"home_products";
  static const String GET_BANNER = HOST_URL+"home_banner";
  static const String GET_ADDRESS_LIST = HOST_URL+"shipping_address";
  static const String ADD_ADDRESS = HOST_URL+"add_shipping_address";
  static const String DELETE_ADDRESS = HOST_URL+"delete_shipping_address";
  static const String EDIT_ADDRESS = HOST_URL+"edit_shipping_address";


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
  ///Category api
  static Future<dynamic> getCategory(params) async {
    final response = await http.post(
      Uri.parse(CATEGORIES),
      body: params
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CategoryRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getCategoryProduct(params) async {
    final response = await http.post(
        Uri.parse(CATEGORY_PRODUCT),
        body: params
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CategoryProductRepo.fromJson(responseJson);
    }
  }

  ///Product api
  static Future<dynamic> getHomeProduct(params) async {
    final response = await http.post(
      Uri.parse(GET_PRODUCT),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ProductRepo.fromJson(responseJson);
    }
  }

  ///Banner api
  static Future<dynamic> getHomeBanner() async {
    final response = await http.post(
      Uri.parse(GET_BANNER),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return BannerRepo.fromJson(responseJson);
    }
  }

  ///Address List
  static Future<dynamic> getAddressList(params) async {
    final response = await http.post(
      Uri.parse(GET_ADDRESS_LIST),
      body: params
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return AddressRepo.fromJson(responseJson);
    }
  }

  ///add address
  static Future<dynamic> addAddress(params) async {
    final response = await http.post(
        Uri.parse(ADD_ADDRESS),
        body: params
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return AddAddressRepo.fromJson(responseJson);
    }
  }

  /// Edit address
   static Future<dynamic> editAddress(params) async {
      final response = await http.post(
          Uri.parse(EDIT_ADDRESS),
          body: params
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        return AddAddressRepo.fromJson(responseJson);
      }
    }


  /// delete address
  static Future<dynamic> deleteAddress(params) async {
    final response = await http.post(
        Uri.parse(DELETE_ADDRESS),
        body: params
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return AddAddressRepo.fromJson(responseJson);
    }
  }


}