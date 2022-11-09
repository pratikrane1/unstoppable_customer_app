class CustomerLoginRepo {
  dynamic status;
  dynamic msg;
  dynamic data;

  CustomerLoginRepo({this.status, this.msg, this.data});
  factory CustomerLoginRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CustomerLoginRepo(
        status: json['status'],
        msg: json['msg'],
        data: json['data'] != null ? new CustomerLogin.fromJson(json['data']) : null,
      );
    } catch (error) {
      return CustomerLoginRepo(
        status: json['result'],
        msg: json['msg'],
        data: null,
      );
    }
  }

  // LoginRepo.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   msg = json['msg'];
  //   data = json['data'] != null ? new LoginModel.fromJson(json['data']) : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['msg'] = this.msg;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class CustomerLogin {
  String? status;
  String? userId;
  String? name;
  String? email;
  String? mobileNo;
  String? address;

  CustomerLogin({this.status, this.userId, this.name, this.email, this.mobileNo, this.address});

  CustomerLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['address'] = this.address;
    return data;
  }
}