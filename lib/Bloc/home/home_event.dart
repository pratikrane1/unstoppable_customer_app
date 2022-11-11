

import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeEvent {}

class GetProduct extends HomeEvent{
  String limit;

  GetProduct({required this.limit});
}

