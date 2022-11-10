

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:unstoppable_customer_app/Bloc/profile/profile_event.dart';
import 'package:unstoppable_customer_app/Bloc/profile/profile_state.dart';

import '../../Api/api.dart';
import '../../Repository/UserRepository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({this.profileRepo}) : super(InitialUserProfileState());
  final UserRepository? profileRepo;


  @override
  Stream<ProfileState> mapEventToState(event) async* {



    // if (event is OnLoadingUserProfile) {
    //   ///Notify loading to UI
    //   yield UserProfileLoading();
    //
    //   ///Fetch API via repository
    //   final UserProfileRepo response = await userProfileRepo!
    //       .fetchUserProfile(
    //     userId: event.userid,
    //     // userId: "874",
    //   );
    //
    //   final Iterable refactorProduct = response.data ?? [];
    //   final userProfileData = refactorProduct.map((item) {
    //     return UserProfileModel.fromJson(item);
    //   }).toList();
    //   if(refactorProduct.length>0){
    //     yield UserProfileSuccess(userProfileData: userProfileData);
    //
    //   }else{
    //     yield UserProfileLoadFail();
    //
    //   }
    //
    //
    // }

    if (event is ProfileUpdate) {
      yield ProfileUpdateLoading();


      MultipartRequest request = new MultipartRequest(
          'POST', Uri.parse(Api.CUSTOMER_PROFILE_UPDATE));
      request.fields['user_id'] = event.user_id;
      request.fields['full_name'] = event.name;
      request.fields['mobile_no'] = event.mobileNo;

      // List<MultipartFile> imageUpload = <MultipartFile>[];



      // if(event.imgFlag=="0"){//0 cropped file,1=existing image
      //   final multipartFile = await http.MultipartFile.fromPath(
      //     'com_logo', event.comLogo!.imagePath.toString(),
      //     // contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
      //   );
      //   imageUpload.add(multipartFile);
      //   request.files.addAll(imageUpload);
      //
      // }else{
      //   request.fields['com_logo'] = "";
      //
      // }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      var resp = json.decode(response.body);
      var data = resp["status"];
      print(data);
      try {
        if (resp["status"] == true) {
          yield ProfileUpdateSuccess(message: "Profile Updated Successfully");
        }else{
          yield ProfileUpdatefail(message: "Failed");

        }
      } catch (e) {
        yield ProfileUpdatefail(message: "Failed");
        rethrow;
      }
    }





  }



}
