class SearchProductRepo {
  bool? status;
  String? msg;
  dynamic result;

  SearchProductRepo({this.status, this.msg, this.result});

  factory SearchProductRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return SearchProductRepo(
        status: json['status'],
        msg: json['msg'],
        // result: json['data'] != null ? new ProductModel.fromJson(json['data']) : null,
        result: json['result'],
        // data: json['data'],
      );
    } catch (error) {
      return SearchProductRepo(
        status: json['result'],
        msg: json['msg'],
        result: null,
      );
    }
  }
}

class ProductSearchModel {
  String? prodId;
  String? prodName;
  String? price;
  String? discountPrice;
  int? discountPercentage;
  String? productUnit;
  String? description;
  String? prodImg;
  String? catId;
  String? subcatId;
  String? sscatId;

  ProductSearchModel(
      {this.prodId,
        this.prodName,
        this.price,
        this.discountPrice,
        this.discountPercentage,
        this.productUnit,
        this.description,
        this.prodImg,
        this.catId,
        this.subcatId,
        this.sscatId});

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodName = json['prod_name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountPercentage = json['discount_percentage'];
    productUnit = json['product_unit'];
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
    data['product_unit'] = this.productUnit;
    data['description'] = this.description;
    data['prod_img'] = this.prodImg;
    data['cat_id'] = this.catId;
    data['subcat_id'] = this.subcatId;
    data['sscat_id'] = this.sscatId;
    return data;
  }
}