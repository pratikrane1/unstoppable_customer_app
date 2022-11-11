import 'package:flutter/cupertino.dart';

import '../../Model/user_profile_model.dart';

@immutable
abstract class ProfileState {}

class InitialUserProfileState extends ProfileState {}

class ProfileLoading extends ProfileState {}


class ProfileSuccess extends ProfileState {
  String message;
  UserProfileRepo? profileData;
  ProfileSuccess({required this.message, required this.profileData});
}


class Profilefail extends ProfileState {
  String message;
  Profilefail({required this.message});
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  String message;
  ProfileUpdateSuccess({required this.message});
}


class ProfileUpdatefail extends ProfileState {
  String message;
  ProfileUpdatefail({required this.message});
}




class ProfileLoadFail extends ProfileState {}