

import 'package:flutter/cupertino.dart';

import '../../Model/cart_model.dart';

@immutable
abstract class CartEvent {}

/// Add to cart
class AddToCart extends CartEvent{
  String user_id;
  String prod_id;
  String quantity;

  AddToCart({required this.user_id, required this.quantity,required this.prod_id});
}

/// Get Cart
class GetCart extends CartEvent{
  String user_id;
  GetCart({required this.user_id});
}


///Delete Cart
class DeleteCart extends CartEvent{
  String user_id;
  String prod_id;

  DeleteCart({required this.user_id,required this.prod_id});
}


class CheckOut extends CartEvent{
  dynamic user_id;
  List<CartListModel> cart;
  dynamic subTotal;
  dynamic shippingCharge;
  dynamic totalAmount;
  String paymentMethod;
  String address;
  CheckOut({required this.user_id, required this.cart,required this.subTotal, required this.shippingCharge,required this.totalAmount,
  required this.paymentMethod, required this.address});
}