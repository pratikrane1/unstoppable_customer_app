import 'package:meta/meta.dart';


@immutable
abstract class SettingsEvent {}


class OnChangePassword extends SettingsEvent {
  String currentPwd,newPwd;

  OnChangePassword({required this.currentPwd,required this.newPwd });
}




