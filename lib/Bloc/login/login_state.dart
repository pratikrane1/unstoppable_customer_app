
import 'package:meta/meta.dart';
import 'package:unstoppable_customer_app/Model/customer_login.dart';


@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFail extends LoginState {
  final String? msg;

  LoginFail({this.msg});
}

class LoginSuccess extends LoginState {
  CustomerLogin userModel;
  String message;
  LoginSuccess({required this.userModel,required this.message});

}

class CustomerRegistrationLoading extends LoginState {}

class CustomerRegistrationSuccess extends LoginState {
  String msg;
  CustomerRegistrationSuccess({required this.msg});
}

class CustomerRegistrationFail extends LoginState {
  String msg;
  CustomerRegistrationFail({required this.msg});
}

// class LogoutLoading extends LoginState {}
//
// class LogoutFail extends LoginState {
//   final String message;
//
//   LogoutFail(this.message);
// }
//
// class LogoutSuccess extends LoginState {}
