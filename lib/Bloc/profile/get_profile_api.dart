

import '../../Api/api.dart';
import '../../Model/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Utils/application.dart';


Future<UserProfileRepo> getUserProfile() async {
  var list;


  final  response = await http.post(
    Uri.parse(Api.HOST_URL+Api.GET_PROFILE),
    body: {"user_id":Application.customerLogin!.userId.toString()},
  );
  // if(response.statusCode == 200){
  //   final responseJson = json.decode(response.body);
  //   print(responseJson);
  //   return UserProfileRepo.fromJson(responseJson);
  // }

  try{
    String respBody = response.body;
    final resp = json.decode(respBody);
    if(resp['status'] == true){
      list = resp['data'];
      print(list);
    }
    // else{
    //   list = resp['data'][0];
    // }
  }catch(e){
    print(e);
    rethrow;
  }
  // if (response.statusCode == 200) {
  //   final responseJson = json.decode(response.body)["data"];
  //   // // print(responseJson);
  //   data = responseJson;
  //   list = data[0];
  //   print(list);
  //   // listdata = list[0];
  //   // userId = listdata["3"];
  //   // print(listdata);
  //   // print("DATA $data");
  //   // print("DATA ${userData}");
  //   // final Iterable refactorProduct = data ?? [];
  //   // final userProfileData = refactorProduct.map((item) {
  //   //   return UserProfileModel.fromJson(item);
  //   // }).toList();
  //   // // print("Data $userProfileData");
  //   // return UserProfileRepo.fromJson(responseJson);
  //
  //
  // }
  return UserProfileRepo.fromJson(list);

}
