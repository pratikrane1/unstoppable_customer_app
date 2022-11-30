class CartRepo {
  bool? status;
  String? msg;

  CartRepo({ this.status, this.msg});
  factory CartRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CartRepo(
          status: json['status'],
          msg: json['msg']
      );
    } catch (error) {
      return CartRepo(
        status: false,
        msg:"",
      );
    }
  }
}

// class Cart {
//   bool? status;
//   String? msg;
//   List<CartListModel>? result;
//   String? cartTotal;
//   String? shippingCharge;
//   String? cartQuantity;
//
//   Cart(
//       {this.status,
//         this.msg,
//         this.result,
//         this.cartTotal,
//         this.shippingCharge,
//         this.cartQuantity});
//
//   Cart.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['result'] != null) {
//       result = <CartListModel>[];
//       json['result'].forEach((v) {
//         result!.add(new CartListModel.fromJson(v));
//       });
//     }
//     cartTotal = json['cart_total'];
//     shippingCharge = json['shipping_charge'];
//     cartQuantity = json['cart_quantity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     if (this.result != null) {
//       data['result'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     data['cart_total'] = this.cartTotal;
//     data['shipping_charge'] = this.shippingCharge;
//     data['cart_quantity'] = this.cartQuantity;
//     return data;
//   }
// }

class CartListRepo {
  bool? status;
  String? msg;
  dynamic result;
  String? cartTotal;
  String? shippingCharge;
  String? cartQuantity;

  CartListRepo({this.result, this.status, this.msg, this.cartTotal,
    this.shippingCharge,
    this.cartQuantity});
  factory CartListRepo.fromJson(Map<dynamic, dynamic> json) {
  // factory CartListRepo.fromJson(Map<String, dynamic> json) {
    try {
      return CartListRepo(
          result: json['result'],
          status: json['status'],
          msg: json['msg'],
          cartTotal : json['cart_total'],
          shippingCharge : json['shipping_charge'],
          cartQuantity : json['cart_quantity'],

      );
    } catch (error) {
      return CartListRepo(
        status: false,
        result: null,
        msg:"",
        cartTotal : "",
        shippingCharge : "",
        cartQuantity : "",
      );
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['cart_total'] = this.cartTotal;
    data['shipping_charge'] = this.shippingCharge;
    data['cart_quantity'] = this.cartQuantity;
    return data;
  }
}

class CartListModel {
  String? prodId;
  String? sscatId;
  String? prodName;
  String? price;
  String? discountPrice;
  String? prodImg;
  String? quantity;
  int? subTotal;

  CartListModel(
      {this.prodId,
        this.sscatId,
        this.prodName,
        this.price,
        this.discountPrice,
        this.prodImg,
        this.quantity,
        this.subTotal});

  CartListModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    sscatId = json['sscat_id'];
    prodName = json['prod_name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    prodImg = json['prod_img'];
    quantity = json['quantity'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['sscat_id'] = this.sscatId;
    data['prod_name'] = this.prodName;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['prod_img'] = this.prodImg;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    return data;
  }
}