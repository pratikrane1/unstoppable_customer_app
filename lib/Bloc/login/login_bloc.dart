import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:unstoppable_customer_app/Model/customer_login.dart';
import '../../Api/api.dart';
import '../../Repository/UserRepository.dart';
import '../../Utils/application.dart';

//for multipart
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../app_bloc.dart';
import '../authentication/authentication_event.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({this.userRepository}) : super(InitialLoginState());
  final UserRepository? userRepository;


  @override
  Stream<LoginState> mapEventToState(event) async* {


    ///Event for login
    if (event is OnLogin) {
      ///Notify loading to UI
      yield LoginLoading();

      ///Fetch API via repository
      final CustomerLoginRepo result = await userRepository!.login(
        email: event.email,
        password: event.password,
      );
      print(result);

      ///Case API fail but not have token
      if (result.status == true) {
        ///Login API success
       //  CustomerLogin user = CustomerLogin.fromJson(result.data);
       CustomerLogin user = new CustomerLogin();
        user.status = result.data!.status.toString();
        user = result.data!;
        AppBloc.authBloc.add(OnSaveUser(user));
        try {
          ///Begin start AuthBloc Event AuthenticationSave

          yield LoginSuccess(userModel: user, message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield LoginFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield LoginFail(msg: result.msg.toString());
      }
    }


    // ///Event for logout
    // if (event is OnLogout) {
    //   yield LogoutLoading();
    //
    //
    //   final deletePreferences = await userRepository!.deleteUser();
    //
    //   ///Clear user Storage user via repository
    //   Application.preferences = null;
    //   // Application.cartModel = null;
    //
    //   /////updated on 10/02/2021
    //   if (deletePreferences) {
    //     yield LogoutSuccess();
    //   } else {
    //     final String message = "Cannot delete user data to storage phone";
    //     throw Exception(message);
    //   }
    // }
    // else {
    //   ///Notify loading to UI
    //   yield LogoutFail("error");
    // }

    if (event is OnRegistration) {
      yield CustomerRegistrationLoading();


      MultipartRequest request = new MultipartRequest(
          'POST', Uri.parse(Api.CUSTOMER_REGISTER));
      request.fields['first_name'] = event.fname;
      request.fields['last_name'] = event.lname;
      request.fields['mobile_no'] = event.mobileNo;
      request.fields['email'] = event.email;

     // List<MultipartFile> imageUpload = <MultipartFile>[];

      // final multipartFile = await http.MultipartFile.fromPath(
      //   'com_logo', event.comLogo!.imagePath.toString(),
      //   // contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
      // );

     // imageUpload.add(multipartFile);
    //  request.files.addAll(imageUpload);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      var resp = json.decode(response.body);
      try {
        if (resp['status'] == true) {
          yield CustomerRegistrationSuccess(msg: resp['msg']);
        }else{
          yield CustomerRegistrationFail(msg: resp['msg']);

        }
      } catch (e) {
        yield CustomerRegistrationFail(msg: resp['msg']);
        rethrow;
      }
    }
  }
}




