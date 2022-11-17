import 'package:meta/meta.dart';


@immutable
abstract class ChangePassEvent {}


class OnChangePassword extends ChangePassEvent {
  String currentPwd,newPwd;

  OnChangePassword({required this.currentPwd,required this.newPwd });
}




