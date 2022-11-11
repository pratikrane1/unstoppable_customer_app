import 'package:meta/meta.dart';


@immutable
abstract class SettingsState {}


class InitialSettingsState extends SettingsState {}


class ChangePassLoading extends SettingsState {}



class ChangePassSuccess extends SettingsState {
 String? message;
 ChangePassSuccess({this.message});
}

class ChangePassFail extends SettingsState {
 String? message;
 ChangePassFail({this.message});
}





