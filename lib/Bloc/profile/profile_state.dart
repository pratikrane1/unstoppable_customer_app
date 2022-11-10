import 'package:flutter/cupertino.dart';

@immutable
abstract class ProfileState {}

class InitialUserProfileState extends ProfileState {}

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