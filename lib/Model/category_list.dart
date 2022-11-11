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
  String? catId;
  String? catName;
  String? catImg;

  CategoryModel({this.catId, this.catName, this.catImg});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catImg = json['cat_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_img'] = this.catImg;
    return data;
  }
}