import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:unstoppable_customer_app/Model/customer_login.dart';
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


    Uri url = Uri.parse(
        "https://unstoppabletrade.in/customer_app/register_customer");
    if (event is OnRegistration) {
      yield CustomerRegistrationLoading();

      Map<String, String> params = {
        'name': event.name,
        'email': event.email,
        'address': event.address,
        'mobile_no': event.mobileNo
      };

      var response;

      try {
        response = await http.post(
          url,
          body: params,
        );
        if (response.statusCode == 200) {
          final resp = json.decode(response.body);

          final CustomerLoginRepo userModel = CustomerLoginRepo.fromJson(resp);

          ///Begin start AuthBloc Event AuthenticationSave
          AppBloc.authBloc.add(OnSaveUser(userModel.data));


          ///Notify loading to UI
          yield CustomerRegistrationSuccess(
              msg: "Registered Successfully"
          );
        }
      } catch (e) {
        yield CustomerRegistrationFail(msg: "Registered fail");
      }
    }
  }
}




