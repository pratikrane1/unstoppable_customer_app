// class CategoryProductRepo {
//   bool? status;
//   String? msg;
//   List<Result>? result;
//
//   CategoryProductRepo({this.status, this.msg, this.result});
//
//   CategoryProductRepo.fromJson(Map<String, dynamic> json) {
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


class CategoryProductRepo {
  bool? status;
  String? msg;
  dynamic result;

  CategoryProductRepo({this.result, this.status, this.msg});
  factory CategoryProductRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CategoryProductRepo(
          result: json['result'],
          status: json['status'],
          msg: json['msg']
      );
    } catch (error) {
      return CategoryProductRepo(
        status: false,
        result: null,
        msg:"",
      );
    }
  }
}


class CategoryProductModel {
  String? prodId;
  String? prodName;
  String? price;
  String? description;
  String? prodImg;
  String? catId;
  String? subcatId;
  String? sscatId;

  CategoryProductModel(
      {this.prodId,
        this.prodName,
        this.price,
        this.description,
        this.prodImg,
        this.catId,
        this.subcatId,
        this.sscatId});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodName = json['prod_name'];
    price = json['price'];
    description = json['description'];
    prodImg = json['prod_img'];
    catId = json['cat_id'];
    subcatId = json['subcat_id'];
    sscatId = json['sscat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['prod_name'] = this.prodName;
    data['price'] = this.price;
    data['description'] = this.description;
    data['prod_img'] = this.prodImg;
    data['cat_id'] = this.catId;
    data['subcat_id'] = this.subcatId;
    data['sscat_id'] = this.sscatId;
    return data;
  }
}