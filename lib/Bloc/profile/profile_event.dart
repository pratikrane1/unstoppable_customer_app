

import 'package:flutter/cupertino.dart';

@immutable
abstract class ProfileEvent {}

class GetProfile extends ProfileEvent{
  String user_id;

  GetProfile({required this.user_id});
}

class ProfileUpdate extends ProfileEvent {
  String user_id;
  String name;
  String mobileNo;

  ProfileUpdate({ required this.name, required this.mobileNo, required this.user_id});
}