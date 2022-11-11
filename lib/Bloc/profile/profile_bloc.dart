

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:unstoppable_customer_app/Bloc/profile/profile_event.dart';
import 'package:unstoppable_customer_app/Bloc/profile/profile_state.dart';

import '../../Api/api.dart';
import '../../Model/user_profile_model.dart';
import '../../Repository/UserRepository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({this.profileRepo}) : super(InitialUserProfileState());
  final UserRepository? profileRepo;


  @override
  Stream<ProfileState> mapEventToState(event) async* {



    if (event is GetProfile) {
      ///Notify loading to UI
      yield ProfileLoading();

      ///Fetch API via repository
      final UserProfile response = await profileRepo!
          .fetchUserProfile(
        user_id: event.user_id,
      );

      print(response);
      print(response.data.name);

      // final Iterable refactorProduct = response.data ?? [];
      // final profileData = refactorProduct.map((item) {
      //   return UserProfileRepo.fromJson(item);
      // }).toList();
      if(response.data!=null){
        yield ProfileSuccess(message: response.msg.toString(), profileData: response.data);

      }else{
        yield Profilefail(message: response.msg.toString());

      }

      // ///Case API fail but not have token
      // if (result.status == true) {
      //   // UserProfileRepo user = UserProfileRepo.fromJson(result.data);
      //   UserProfileRepo user = new UserProfileRepo();
      //   user.status = result.data!.status.toString();
      //   user = result.data!;
      //   // AppBloc.authBloc.add(OnSaveUser(user));
      //   try {
      //     ///Begin start AuthBloc Event AuthenticationSave
      //
      //     yield ProfileSuccess(message: result.msg.toString());
      //   } catch (error) {
      //     ///Notify loading to UI
      //     yield Profilefail(message: result.msg.toString());
      //   }
      // } else {
      //   ///Notify loading to UI
      //   yield Profilefail(message: result.msg.toString());
      // }


    }

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
