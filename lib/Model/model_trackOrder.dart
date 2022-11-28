class TrackOrderResp {
  dynamic status;
  dynamic msg;
  dynamic result;

  TrackOrderResp({this.status, this.msg, this.result});

  factory TrackOrderResp.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TrackOrderResp(
        status: json['status'],
        msg: json['msg'],
        // result: json['data'] != null ? new ProductModel.fromJson(json['data']) : null,
        result: json['result'],
        // data: json['data'],
      );
    } catch (error) {
      return TrackOrderResp(
        status: json['result'],
        msg: json['msg'],
        result: null,
      );
    }
  }
}

// class TrackOrder {
//   String? retRplc;
//   List<TrackData>? trackData;
//
//   TrackOrder({this.retRplc, this.trackData});
//
//   TrackOrder.fromJson(Map<String, dynamic> json) {
//     retRplc = json['ret_rplc'];
//     if (json['track_data'] != null) {
//       trackData = <TrackData>[];
//       json['track_data'].forEach((v) {
//         trackData?.add(new TrackData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ret_rplc'] = this.retRplc;
//     if (this.trackData != null) {
//       data['track_data'] = this.trackData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
class TrackData {
  String? orderStatus;
  String? date;

  TrackData({this.orderStatus, this.date});

  TrackData.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_status'] = this.orderStatus;
    data['date'] = this.date;
    return data;
  }
}