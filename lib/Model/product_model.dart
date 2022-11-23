// class ProductRepo {
//   bool? status;
//   String? msg;
//   List<Result>? result;
//
//   ProductRepo({this.status, this.msg, this.result});
//
//   ProductRepo.fromJson(Map<String, dynamic> json) {
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
class ProductRepo {
  dynamic status;
  dynamic msg;
  dynamic result;

  ProductRepo({this.status, this.msg, this.result});
  factory ProductRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ProductRepo(
        status: json['status'],
        msg: json['msg'],
        // result: json['data'] != null ? new ProductModel.fromJson(json['data']) : null,
        result: json['result'],
        // data: json['data'],
      );
    } catch (error) {
      return ProductRepo(
        status: json['result'],
        msg: json['msg'],
        result: null,
      );
    }
  }
}

class ProductModel {
  String? prodId;
  String? prodName;
  String? price;
  String? discountPrice;
  int? discountPercentage;
  String? quantity;
  String? description;
  String? prodImg;
  String? catId;
  String? subcatId;
  String? sscatId;

  ProductModel(
      {this.prodId,
        this.prodName,
        this.price,
        this.discountPrice,
        this.discountPercentage,
        this.quantity,
        this.description,
        this.prodImg,
        this.catId,
        this.subcatId,
        this.sscatId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodName = json['prod_name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountPercentage = json['discount_percentage'];
    quantity = json['product_unit'];
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
    data['discount_price'] = this.discountPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['product_unit'] = this.quantity;
    data['description'] = this.description;
    data['prod_img'] = this.prodImg;
    data['cat_id'] = this.catId;
    data['subcat_id'] = this.subcatId;
    data['sscat_id'] = this.sscatId;
    return data;
  }
}