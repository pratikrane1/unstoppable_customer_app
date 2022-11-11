

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:unstoppable_customer_app/Bloc/contactUs/contactUs_event.dart';
import 'package:unstoppable_customer_app/Bloc/contactUs/contactUs_state.dart';
import 'package:unstoppable_customer_app/Bloc/profile/profile_event.dart';
import 'package:unstoppable_customer_app/Bloc/profile/profile_state.dart';

import '../../Api/api.dart';
import '../../Model/contact_us_model.dart';
import '../../Repository/UserRepository.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc({this.contactUsRepo}) : super(InitialContactUsState());
  final UserRepository? contactUsRepo;


  @override
  Stream<ContactUsState> mapEventToState(event) async* {

    if (event is ContactUs) {
      ///Notify loading to UI
      yield ContactUsLoading();

      ///Fetch API via repository
      final ContactUsRepo result = await contactUsRepo!.contactUs(
        name: event.name,
        email: event.email,
        mobileNo: event.mobileNo,
        message: event.msg
      );
      print(result);

      ///Case API fail but not have token
      if (result.status == true) {
        ///Login API success
        //  CustomerLogin user = CustomerLogin.fromJson(result.data);
        // CustomerLogin user = new CustomerLogin();
        // user.status = result.data!.status.toString();
        // user = result.data!;
        // AppBloc.authBloc.add(OnSaveUser(user));
        try {
          ///Begin start AuthBloc Event AuthenticationSave

          yield ContactUsSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield ContactUsfail(message: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield ContactUsfail(message: result.msg.toString());
      }
    }





  }



}
