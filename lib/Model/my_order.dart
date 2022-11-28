class MyOrdersResp {
  bool? status;
  String? msg;
  dynamic result;

  MyOrdersResp({this.status, this.msg, this.result});

  factory MyOrdersResp.fromJson(Map<dynamic, dynamic> json) {
    try {
      return MyOrdersResp(
        status: json['status'],
        msg: json['msg'],
        // result: json['data'] != null ? new ProductModel.fromJson(json['data']) : null,
        result: json['result'],
        // data: json['data'],
      );
    } catch (error) {
      return MyOrdersResp(
        status: json['result'],
        msg: json['msg'],
        result: null,
      );
    }
  }
}

class Orders {
  String? orderId;
  String? subTotal;
  String? shippingCharge;
  String? totalAmount;
  String? paymentMethod;
  String? paymentStatus;
  String? orderDate;
  String? billingAddress;
  List<Products>? products;

  Orders(
      {this.orderId,
        this.subTotal,
        this.shippingCharge,
        this.totalAmount,
        this.paymentMethod,
        this.paymentStatus,
        this.orderDate,
        this.billingAddress,
        this.products});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    subTotal = json['sub_total'];
    shippingCharge = json['shipping_charge'];
    totalAmount = json['total_amount'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    orderDate = json['order_date'];
    billingAddress = json['billing_address'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['sub_total'] = this.subTotal;
    data['shipping_charge'] = this.shippingCharge;
    data['total_amount'] = this.totalAmount;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['order_date'] = this.orderDate;
    data['billing_address'] = this.billingAddress;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? prodId;
  String? prodName;
  String? description;
  String? sscatId;
  String? price;
  String? quantity;
  String? imgPath;

  Products(
      {this.prodId,
        this.prodName,
        this.description,
        this.sscatId,
        this.price,
        this.quantity,
        this.imgPath});

  Products.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    prodName = json['prod_name'];
    description = json['description'];
    sscatId = json['sscat_id'];
    price = json['price'];
    quantity = json['quantity'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['prod_name'] = this.prodName;
    data['description'] = this.description;
    data['sscat_id'] = this.sscatId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['img_path'] = this.imgPath;
    return data;
  }
}


// class MyOrdersResp {
//   bool? status;
//   String? msg;
//   String? orderId;
//   String? subTotal;
//   String? shippingCharge;
//   String? totalAmount;
//   String? paymentMethod;
//   String? paymentStatus;
//   String? orderDate;
//   String? billingAddress;
//   dynamic orders;
//
//   MyOrdersResp(
//       {this.status,
//         this.msg,
//         this.orderId,
//         this.subTotal,
//         this.shippingCharge,
//         this.totalAmount,
//         this.paymentMethod,
//         this.paymentStatus,
//         this.orderDate,
//         this.billingAddress,
//         this.orders});
//
//   factory MyOrdersResp.fromJson(Map<dynamic, dynamic> json) {
//     try {
//       return MyOrdersResp(
//           status: json['status'],
//           msg: json['msg'],
//         orderId: json['order_id'],
//         subTotal: json['sub_total'],
//         shippingCharge: json['shipping_charge'],
//         totalAmount: json['total_amount'],
//         paymentMethod: json['payment_method'],
//         paymentStatus: json['payment_status'],
//         orderDate: json['order_date'],
//         billingAddress : json['billing_address'],
//         orders : json['products'],
//
//       );
//     } catch (error) {
//       return MyOrdersResp(
//         status: false,
//         orders: "",
//         msg:"",
//         orderId : "",
//         subTotal : "",
//         shippingCharge : "",
//         totalAmount : "",
//         paymentMethod : "",
//         paymentStatus : "",
//         orderDate : "",
//         billingAddress : "",
//       );
//     }
//   }
// }
//
// class Orders {
//   String? prodId;
//   String? prodName;
//   String? description;
//   String? price;
//   String? sscatId;
//   String? quantity;
//   String? imgPath;
//
//   Orders(
//       {this.prodId,
//         this.prodName,
//         this.description,
//         this.price,
//         this.sscatId,
//         this.quantity,
//         this.imgPath});
//
//   Orders.fromJson(Map<String, dynamic> json) {
//     prodId = json['prod_id'];
//     prodName = json['prod_name'];
//     description = json['description'];
//     price = json['price'];
//     sscatId = json['sscatId'];
//     quantity = json['quantity'];
//     imgPath = json['img_path'];
//   }
//
//
//
//
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prod_id'] = this.prodId;
//     data['prod_name'] = this.prodName;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['sscatId'] = this.sscatId;
//     data['quantity'] = this.quantity;
//     data['img_path'] = this.imgPath;
//     return data;
//   }
// }


// class MyOrdersResp {
//   dynamic? status;
//   dynamic? msg;
//   String? orderId;
//   String? subTotal;
//   String? shippingCharge;
//   String? totalAmount;
//   String? paymentMethod;
//   String? paymentStatus;
//   String? orderDate;
//   String? billingAddress;
//   dynamic? orders;
//
//   MyOrdersResp(
//       {this.status,
//         this.msg,
//         this.orderId,
//         this.subTotal,
//         this.shippingCharge,
//         this.totalAmount,
//         this.paymentMethod,
//         this.paymentStatus,
//         this.orderDate,
//         this.billingAddress,
//         this.orders});
//
//   factory MyOrdersResp.fromJson(Map<dynamic, dynamic> json) {
//     try {
//       return MyOrdersResp(
//           status: json['status'],
//           msg: json['msg'],
//         orderId: json['order_id'],
//         subTotal: json['sub_total'],
//         shippingCharge: json['shipping_charge'],
//         totalAmount: json['total_amount'],
//         paymentMethod: json['payment_method'],
//         paymentStatus: json['payment_status'],
//         orderDate: json['order_date'],
//         billingAddress : json['billing_address'],
//         orders : json['orders'],
//
//       );
//     } catch (error) {
//       return MyOrdersResp(
//         status: false,
//         orders: null,
//         msg:"",
//         orderId : "",
//         subTotal : "",
//         shippingCharge : "",
//         totalAmount : "",
//         paymentMethod : "",
//         paymentStatus : "",
//         orderDate : "",
//         billingAddress : "",
//       );
//     }
//   }
// }
//
// class Orders {
//   String? prodId;
//   String? prodName;
//   String? description;
//   String? price;
//   String? quantity;
//   String? imgPath;
//
//   Orders(
//       {this.prodId,
//         this.prodName,
//         this.description,
//         this.price,
//         this.quantity,
//         this.imgPath});
//
//   Orders.fromJson(Map<String, dynamic> json) {
//     prodId = json['prod_id'];
//     prodName = json['prod_name'];
//     description = json['description'];
//     price = json['price'];
//     quantity = json['quantity'];
//     imgPath = json['img_path'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prod_id'] = this.prodId;
//     data['prod_name'] = this.prodName;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     data['img_path'] = this.imgPath;
//     return data;
//   }
// }