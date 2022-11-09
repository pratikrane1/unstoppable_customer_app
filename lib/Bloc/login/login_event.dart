
abstract class LoginEvent {}

class OnLogin extends LoginEvent {

  var email,password;

  OnLogin({this.email,this.password});

}

class OnRegistration extends LoginEvent {

  var name,email,mobileNo,address;

  OnRegistration({this.name,this.email,this.address,this.mobileNo});

}



// class OnLogout extends LoginEvent {
//   OnLogout();
// }
