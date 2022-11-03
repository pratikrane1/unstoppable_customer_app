

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unstoppable_customer_app/Screen/Cart/thankyou_screen.dart';

import '../../Constant/theme_colors.dart';
import '../../Widget/app_button.dart';
import 'address_screen.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  int? typeId;
  String? radioBtnType;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'SF-Pro-Display-Regular',
              color: ThemeColors.whiteTextColor
          ),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Delivery Address", style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'SF-Pro-Display-Regular',
                      fontWeight: FontWeight.w500
                  ),),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.maps_home_work_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pratik Rane", style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular',
                                      fontWeight: FontWeight.w500
                                  ),),
                                  Text("Plot 52B, Gandhi Layout"),
                                  Text("Katol Road"),
                                  Text("Nagpur, Maharashtra, 440013"),
                                  Text("India"),
                                  Row(
                                    children: [
                                      Text("Phone Number:"),
                                      Text("9765819138")
                                    ],
                                  ),



                                ],
                              ),

                            ],
                          ),
                          Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                AppButton(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  text: 'Edit Address',
                                  // loading: login is LoginLoading,
                                  disableTouchWhenLoading: true,
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Text("Payment Method", style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SF-Pro-Display-Regular',
                    fontWeight: FontWeight.w500
                ),),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [



                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // _atomaticManualOther(),
                              // _semiatomaticMultiporpose(),
                              Radio(
                                value: 1,
                                groupValue: typeId,
                                onChanged: (val) {
                                  setState(() {
                                    radioBtnType = 'COD';
                                    typeId = 1;
                                  });
                                },
                              ),
                              Text(
                                'Cash on Delivery (COD)',
                                  style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SF-Pro-Display-Regular',
                                  fontWeight: FontWeight.w400
                              ),
                              ),

                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: typeId,
                                onChanged: (val) {
                                  setState(() {
                                    radioBtnType = 'PayTM';
                                    typeId = 3;
                                  });
                                },
                              ),
                              Image.asset("assets/images/paytm-icon.png",
                                height: 70,
                                width: 50,)

                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child:
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Center(
              child: AppButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ThankYouPage()));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
                text: 'Proceed to Buy',
                // loading: login is LoginLoading,
                disableTouchWhenLoading: true,
              ),
            ),
          ),
        ),
      ),
    );

  }

}