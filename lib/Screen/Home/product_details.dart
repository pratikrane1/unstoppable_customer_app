import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:unstoppable_customer_app/Bloc/cart/cart_event.dart';
import '../../Bloc/cart/cart_bloc.dart';
import '../../Bloc/cart/cart_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/cart_model.dart';
import '../../Model/product_model.dart';
import '../../Utils/application.dart';
import '../../Widget/app_button.dart';
import '../../Widget/common.dart';
import '../Cart/cart.dart';
import '../Login/sign_in.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetail extends StatefulWidget {
  ProductModel productData;
  ProductDetail({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var mainHeight, mainWidth;
  var quantity = 1;
  var totalValue = 0;
  int prodValue = 15000;
  bool loading = false;

  CartBloc? _cartBloc;
  CartListRepo? cartData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartBloc!
        .add(GetCart(user_id: Application.customerLogin!.userId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ThemeColors.whiteTextColor,
            ),
          ),
          title: Text(
            "Product Detail",
            style: TextStyle(
                color: ThemeColors.whiteTextColor,
                fontFamily: 'SF-Pro-Display-Regular',
                fontSize: 20),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage(backIcon: true,)));
                  },
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                    size: 30,
                    color: ThemeColors.whiteTextColor,
                  ),
                ),
                // Application.cart!.cartQuantity != null ?
                Application.cart == null ? Container() :
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ThemeColors.discountBackgroundColor,
                    ),
                    child: Center(
                        child: Text(Application.cart!.cartQuantity.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.whiteTextColor
                      ),
                    )),
                  ),
                )
                    // : Container(),
              ],
            )
          ],
        ),
        backgroundColor: ThemeColors.backgroundColor,
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is AddCartSuccess) {
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                // =>Address()));
                // Fluttertoast.showToast(
                //     msg: state.message.toString());
                final snackBar = SnackBar(
                  backgroundColor: ThemeColors.baseThemeColor,
                  content: Text(state.message.toString()),
                  action: SnackBarAction(
                    label: 'Cart',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage(backIcon: true,)));
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is AddCartLoading) {
                loading = false;
              }
              if (state is AddCartfail) {
                Fluttertoast.showToast(msg: state.message.toString());
                loading = false;
              }
              if (state is CartListSuccess) {
                cartData = state.cartData;
              }
            },

            child: Container(
              // color: Color(0xff000029),

              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    // elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productData.prodName.toString(),
                            style: TextStyle(
                                fontFamily: 'SF-Pro-Display-Medium',
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              Center(
                                child: CachedNetworkImage(
                                  height: 300,
                                  width: 340,

                                  filterQuality: FilterQuality.medium,
                                  // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                                  // imageUrl: "https://picsum.photos/250?image=9",
                                  imageUrl: "${widget.productData.prodImg}",
                                  placeholder: (context, url) {
                                    return Shimmer.fromColors(
                                      baseColor: Theme.of(context).hoverColor,
                                      highlightColor:
                                          Theme.of(context).highlightColor,
                                      enabled: true,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Shimmer.fromColors(
                                      baseColor: Theme.of(context).hoverColor,
                                      highlightColor:
                                          Theme.of(context).highlightColor,
                                      enabled: true,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(Icons.error),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              widget.productData.discountPercentage != null
                                  ? Positioned(
                                      top: 5,
                                      // left: 18,
                                      right: 18,
                                      child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: ThemeColors
                                              .discountBackgroundColor,
                                          child: Text(
                                            "${widget.productData.discountPercentage}%\n off",
                                            style: TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Thin',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    ThemeColors.whiteTextColor),
                                          )),
                                    )
                                  : Container(),
                              // Positioned(
                              //   top: 5,
                              //   right: 10,
                              //   child: CircleAvatar(
                              //       radius: 20,
                              //       backgroundColor: ThemeColors.whiteTextColor.withOpacity(0.8),
                              //       child: IconButton(
                              //         icon: Icon(Icons.share_outlined,
                              //           color: ThemeColors.greyTextColor,
                              //           size: 25,),
                              //         onPressed: (){
                              //           share();
                              //         },
                              //       )
                              //   ),
                              // )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    // width: MediaQuery.of(context).size.width /2.1,
                                    child: Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(4),
                                      },
                                      children: [
                                        TableRow(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text(
                                              "MRP:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: ThemeColors
                                                      .textFieldBgColor,
                                                  fontSize: 18.0,
                                                  fontFamily:
                                                      'SF-Pro-Display-Regular'),
                                            ),
                                            Text(
                                              "\u{20B9} ${widget.productData.price}",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.normal,
                                                  color: ThemeColors
                                                      .textFieldBgColor,
                                                  fontSize: 18.0,
                                                  fontFamily:
                                                      'SF-Pro-Display-Regular'),
                                            ),
                                          ],
                                        ),

                                        // Deal Price
                                        TableRow(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Deal Price:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontFamily:
                                                      'SF-Pro-Display-Regular'),
                                            ),
                                            Text(
                                              "\u{20B9} ${widget.productData.discountPrice}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 22.0,
                                                  fontFamily:
                                                      'SF-Pro-Display-Regular'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    width: 5,
                                  ),

                                  // Container(
                                  //   padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(10.0),
                                  //     border: Border.all(
                                  //       color: ThemeColors.buttonColor, style: BorderStyle.solid, ),
                                  //   ),
                                  //   child: DropdownButton(
                                  //     underline: DropdownButtonHideUnderline(child: Container()),
                                  //
                                  //     // Initial Value
                                  //     value: dropdownvalue,
                                  //
                                  //     // Down Arrow Icon
                                  //     icon: const Icon(Icons.keyboard_arrow_down),
                                  //
                                  //     // Array list of items
                                  //     items: items.map((String items) {
                                  //       return DropdownMenuItem(
                                  //         value: items,
                                  //         child: Text(items, style: TextStyle(
                                  //             fontFamily: 'SF-Pro-Display-Regular',
                                  //             fontSize: 18
                                  //         ),),
                                  //       );
                                  //     }).toList(),
                                  //     // After selecting the desired option,it will
                                  //     // change button value to selected value
                                  //     onChanged: (String? newValue) {
                                  //       setState(() {
                                  //         dropdownvalue = newValue!;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: ListTile(
                              title: Text(
                                'Select the quantity:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontFamily: 'SF-Pro-Display-Regular'),
                              ),
                              trailing: Container(
                                width: mainWidth / 3,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (quantity > 1) {
                                            quantity--;
                                            totalValue = prodValue * quantity;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantity < 10) {
                                            quantity++;
                                            totalValue = prodValue * quantity;
                                          }
                                          // var qty = cert.cart[index].qty! + 1;
                                          // cert.updateProduct(
                                          //     cert.cart[index].id,
                                          //     cert.cart[index].price.toString(),
                                          //     qty);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: ThemeColors.baseThemeColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: Center(
                                  child: AppButton(
                                    onPressed: () async {
                                      _cartBloc!.add(AddToCart(
                                          user_id: Application
                                              .customerLogin!.userId
                                              .toString(),
                                          prod_id: widget.productData.prodId
                                              .toString(),
                                          quantity: quantity.toString()));
                                    },
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    text: 'Add to cart',
                                    loading: true,
                                    // disableTouchWhenLoading: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Product detail
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Product Details",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'SF-Pro-Display-Bold'),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              child: Html(
                            data: widget.productData.description.toString(),
                          )),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Description
                ],
              ),
            ),

            // Center(
            //   child: CircularProgressIndicator(),
            // )
          );
        }));
  }
}
