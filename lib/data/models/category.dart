class CategoryModel {
  String? sscatId;
  String? ssCatName;
  String? ssCatImg;
  String? subcatId;

  CategoryModel({this.sscatId, this.ssCatName, this.ssCatImg, this.subcatId});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sscatId = json['sscat_id'];
    ssCatName = json['ss_cat_name'];
    ssCatImg = json['ss_cat_img'];
    subcatId = json['subcat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sscat_id'] = this.sscatId;
    data['ss_cat_name'] = this.ssCatName;
    data['ss_cat_img'] = this.ssCatImg;
    data['subcat_id'] = this.subcatId;
    return data;
  }
}