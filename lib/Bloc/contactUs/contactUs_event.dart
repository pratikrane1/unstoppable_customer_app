

import 'package:flutter/cupertino.dart';

@immutable
abstract class ContactUsEvent {}

class ContactUs extends ContactUsEvent {
  String email;
  String name;
  String mobileNo;
  String msg;

  ContactUs({ required this.name, required this.mobileNo, required this.email, required this.msg,});
}