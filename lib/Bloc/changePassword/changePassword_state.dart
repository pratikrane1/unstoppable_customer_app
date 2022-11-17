import 'package:meta/meta.dart';


@immutable
abstract class ChangePassState {}


class InitialSettingsState extends ChangePassState {}


class ChangePassLoading extends ChangePassState {}



class ChangePassSuccess extends ChangePassState {
 String? message;
 ChangePassSuccess({this.message});
}

class ChangePassFail extends ChangePassState {
 String? message;
 ChangePassFail({this.message});
}





