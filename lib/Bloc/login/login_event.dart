
abstract class LoginEvent {}

class OnLogin extends LoginEvent {

  var email,password;

  OnLogin({this.email,this.password});

}

class OnRegistration extends LoginEvent {

  var fname,email,mobileNo,lname;

  OnRegistration({this.fname,this.email,this.lname,this.mobileNo});

}



// class OnLogout extends LoginEvent {
//   OnLogout();
// }
