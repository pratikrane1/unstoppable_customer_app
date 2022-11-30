import 'package:flutter/cupertino.dart';

import '../../Model/address_model.dart';
import '../../Model/cart_model.dart';

@immutable
abstract class CartState {}

class InitialCartState extends CartState {}


/// Add Cart
class AddCartLoading extends CartState {}


class AddCartSuccess extends CartState {
  String message;
  AddCartSuccess({required this.message});
}


class AddCartfail extends CartState {
  String message;
  AddCartfail({required this.message});
}


/// Cart List
class CartListLoading extends CartState {}


class CartListSuccess extends CartState {
  String message;
  List<CartListModel> cartList;
  dynamic cartData;
  CartListSuccess({required this.message, required this.cartList, required this.cartData});
}


class CartListfail extends CartState {
  String message;
  CartListfail({required this.message});
}


///Delete Cart
class DeleteCartLoading extends CartState {}


class DeleteCartSuccess extends CartState {
  String message;
  DeleteCartSuccess({required this.message,});
}


class DeleteCartfail extends CartState {
  String message;
  DeleteCartfail({required this.message});
}


///Checkout
class CheckOutLoading extends CartState {}


class CheckOutSuccess extends CartState {
  String message;
  CheckOutSuccess({required this.message,});
}


class CheckOutfail extends CartState {
  String message;
  CheckOutfail({required this.message});
}