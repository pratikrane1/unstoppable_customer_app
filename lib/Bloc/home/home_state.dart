import 'package:flutter/cupertino.dart';

import '../../Model/banner_model.dart';
import '../../Model/category_list.dart';
import '../../Model/product_model.dart';
import '../../Model/user_profile_model.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ProductLoading extends HomeState {}

class SearchProductLoading extends HomeState {}

class SearchProductSuccess extends HomeState {
  String message;
  List<ProductModel>? productData;
  SearchProductSuccess({required this.message, required this.productData});
}

class SearchProductfail extends HomeState {
  String message;
  SearchProductfail({required this.message});
}

class ProductSuccess extends HomeState {
  String message;
  List<ProductModel>? productData;
  ProductSuccess({required this.message, required this.productData});
}


class Productfail extends HomeState {
  String message;
  Productfail({required this.message});
}

class BannerLoading extends HomeState {}

class GetBannerSuccess extends HomeState {
  String message;
  List<BannerModel>? bannerList;
  GetBannerSuccess({required this.message, required this.bannerList});
}


class GetBannerfail extends HomeState {
  String message;
  GetBannerfail({required this.message});
}


class CategoryLoading extends HomeState {}

class GetCategorySuccess extends HomeState {
  String message;
  List<CategoryModel>? categoryList;
  GetCategorySuccess({required this.message, required this.categoryList});
}


class GetCategoryfail extends HomeState {
  String message;
  GetCategoryfail({required this.message});
}


