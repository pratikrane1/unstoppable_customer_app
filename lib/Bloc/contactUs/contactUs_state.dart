import 'package:flutter/cupertino.dart';

@immutable
abstract class ContactUsState {}

class InitialContactUsState extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsSuccess extends ContactUsState {
  String message;
  ContactUsSuccess({required this.message});
}


class ContactUsfail extends ContactUsState {
  String message;
  ContactUsfail({required this.message});
}


