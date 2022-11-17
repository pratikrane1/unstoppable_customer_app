// class BannerRepo {
//   bool? status;
//   String? msg;
//   List<Result>? result;
//
//   BannerRepo({this.status, this.msg, this.result});
//
//   BannerRepo.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['result'] != null) {
//       result = <Result>[];
//       json['result'].forEach((v) {
//         result!.add(new Result.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     if (this.result != null) {
//       data['result'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class BannerRepo {
  dynamic status;
  dynamic msg;
  dynamic result;

  BannerRepo({this.status, this.msg, this.result});
  factory BannerRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return BannerRepo(
        status: json['status'],
        msg: json['msg'],
        // result: json['data'] != null ? new ProductModel.fromJson(json['data']) : null,
        result: json['result'],
        // data: json['data'],
      );
    } catch (error) {
      return BannerRepo(
        status: json['result'],
        msg: json['msg'],
        result: null,
      );
    }
  }
}

class BannerModel {
  String? bannerId;
  String? bannerImg;

  BannerModel({this.bannerId, this.bannerImg});

  BannerModel.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_img'] = this.bannerImg;
    return data;
  }
}