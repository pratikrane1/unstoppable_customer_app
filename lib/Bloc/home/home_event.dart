

import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeEvent {}

class GetProduct extends HomeEvent{
  String limit;

  GetProduct({required this.limit});
}

class GetBanners extends HomeEvent{
  GetBanners();
}

class GetHomeCategory extends HomeEvent{
  String perPage;
  String startFrom;
  GetHomeCategory({required this.perPage, required this.startFrom});
}