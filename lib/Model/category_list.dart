class CategoryRepo {
  bool? status;
  String? msg;
  dynamic result;

  CategoryRepo({this.result, this.status, this.msg});
  factory CategoryRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CategoryRepo(
        result: json['result'],
        status: json['status'],
        msg: json['msg']
      );
    } catch (error) {
      return CategoryRepo(
        status: false,
        result: null,
        msg:"",
      );
    }
  }
}

class CategoryModel {
  String? subCatId;
  String? ssCatId;
  String? ssCatName;
  String? ssCatImg;

  CategoryModel({this.subCatId, this.ssCatId, this.ssCatName, this.ssCatImg});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    subCatId = json['subcat_id'];
    ssCatId = json['sscat_id'];
    ssCatName = json['ss_cat_name'];
    ssCatImg = json['ss_cat_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcat_id'] = this.subCatId;
    data['sscat_id'] = this.ssCatId;
    data['ss_cat_name'] = this.ssCatName;
    data['ss_cat_img'] = this.ssCatImg;
    return data;
  }
}