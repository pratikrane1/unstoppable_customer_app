import 'package:flutter/cupertino.dart';

import '../../Model/product_model.dart';
import '../../Model/user_profile_model.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ProductLoading extends HomeState {}


class ProductSuccess extends HomeState {
  String message;
  List<ProductModel>? productData;
  ProductSuccess({required this.message, required this.productData});
}


class Productfail extends HomeState {
  String message;
  Productfail({required this.message});
}

// class ProfileUpdateLoading extends ProfileState {}
//
// class ProfileUpdateSuccess extends ProfileState {
//   String message;
//   ProfileUpdateSuccess({required this.message});
// }
//
//
// class ProfileUpdatefail extends ProfileState {
//   String message;
//   ProfileUpdatefail({required this.message});
// }
//
//
//
//
// class ProfileLoadFail extends ProfileState {}