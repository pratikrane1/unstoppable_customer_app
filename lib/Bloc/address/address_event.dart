

import 'package:flutter/cupertino.dart';

@immutable
abstract class AddressEvent {}

class GetAddressList extends AddressEvent{
  String user_id;

  GetAddressList({required this.user_id});
}

class AddAddress extends AddressEvent{
  String user_id;
  String streetAddress;
  String city;
  String state;
  String pinCode;

  AddAddress({required this.user_id, required this.streetAddress, required this.city, required this.state, required this.pinCode});
}

class EditAddress extends AddressEvent{
  String id;
  String user_id;
  String streetAddress;
  String city;
  String state;
  String pinCode;

  EditAddress({required this.id,required this.user_id, required this.streetAddress, required this.city, required this.state, required this.pinCode});
}

class DeleteAddress extends AddressEvent{
  String user_id;
  String id;

  DeleteAddress({required this.user_id, required this.id});
}


