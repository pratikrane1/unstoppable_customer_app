import 'package:flutter/cupertino.dart';

import '../../Model/address_model.dart';

@immutable
abstract class AddressState {}

class InitialAddressState extends AddressState {}


/// address list
class AddressListLoading extends AddressState {}


class AddressListSuccess extends AddressState {
  String message;
  List<AddressModel>? addressList;
  AddressListSuccess({required this.message, required this.addressList});
}


class AddressListfail extends AddressState {
  String message;
  AddressListfail({required this.message});
}


/// Add address
class AddAddressLoading extends AddressState {}


class AddAddressSuccess extends AddressState {
  String message;
  AddAddressSuccess({required this.message});
}


class AddAddressfail extends AddressState {
  String message;
  AddAddressfail({required this.message});
}


/// Edit address
class EditAddressLoading extends AddressState {}


class EditAddressSuccess extends AddressState {
  String message;
  EditAddressSuccess({required this.message});
}


class EditAddressfail extends AddressState {
  String message;
  EditAddressfail({required this.message});
}



/// Delete address
class DeleteAddressLoading extends AddressState {}


class DeleteAddressSuccess extends AddressState {
  String message;
  DeleteAddressSuccess({required this.message});
}


class DeleteAddressfail extends AddressState {
  String message;
  DeleteAddressfail({required this.message});
}
