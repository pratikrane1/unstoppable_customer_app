

import 'package:flutter/cupertino.dart';

@immutable
abstract class ProfileEvent {}

class ProfileUpdate extends ProfileEvent {
  String user_id;
  String name;
  String mobileNo;

  ProfileUpdate({ required this.name, required this.mobileNo, required this.user_id});
}