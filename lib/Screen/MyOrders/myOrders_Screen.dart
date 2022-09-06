
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unstoppable_customer_app/Widget/drawer.dart';

import '../../Constant/theme_colors.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key,}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("My Orders", style: TextStyle(color: ThemeColors.whiteTextColor),),

                // myAppBarIcon(),
              ],
            ),
          ],
        ),

      ),
      drawer: DrawerWidget(),
    );
  }

}