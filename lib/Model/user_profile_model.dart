// class UserProfile {
//   bool? status;
//   String? msg;
//   dynamic data;
//
//   UserProfile({this.status, this.msg, this.data});
//
//   UserProfile.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     data = json['data'];
//     // data = json['data'] != null ? new UserProfileRepo.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

class UserProfile {
  dynamic status;
  dynamic msg;
  dynamic data;

  UserProfile({this.status, this.msg, this.data});
  factory UserProfile.fromJson(Map<dynamic, dynamic> json) {
    try {
      return UserProfile(
        status: json['status'],
        msg: json['msg'],
        data: json['data'] != null ? new UserProfileRepo.fromJson(json['data']) : null,
        // data: json['data'],
      );
    } catch (error) {
      return UserProfile(
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

class UserProfileRepo {
  String? status;
  String? userId;
  String? name;
  String? email;
  String? mobileNo;
  String? password;
  String? address;
  String? profile_img;

  UserProfileRepo(
      {this.status,
        this.userId,
        this.name,
        this.email,
        this.mobileNo,
        this.password,
      this.address,
      this.profile_img});

  UserProfileRepo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    address = json['address'];
    profile_img = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['password'] = this.password;
    data['address'] = this.address;
    data['profile_img'] = this.profile_img;
    return data;
  }
}