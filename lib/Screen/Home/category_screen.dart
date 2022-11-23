

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Model/category_product_model.dart';
import 'package:unstoppable_customer_app/Screen/Home/product_details.dart';

import '../../Bloc/category/category_bloc.dart';
import '../../Bloc/category/category_event.dart';
import '../../Bloc/category/category_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/category_list.dart';
import '../../Model/product_model.dart';
import '../Cart/cart.dart';

class CategoryScreen extends StatefulWidget {
  CategoryModel catData;
  CategoryScreen({Key? key,required this.catData}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryBloc? _productBloc;
  List<ProductModel> categoryProductList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productBloc = BlocProvider.of<CategoryBloc>(context);
    _productBloc!.add(OnLoadingCategoryProductList(ssCatId: widget.catData.sscatId.toString()));
    // _productBloc!.add(OnLoadingCategoryProductList(ssCatId: '3651'));
  }

  Future<Null> _onRefresh() {
    setState(() {
      _productBloc!.add(OnLoadingCategoryProductList(ssCatId: widget.catData.sscatId.toString()));

    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }


  @override
  Widget build(BuildContext context) {
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
          child: Icon(Icons.arrow_back_ios,
            color: ThemeColors.whiteTextColor,),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.catData.ssCatName.toString(),
                  style: TextStyle(color: ThemeColors.whiteTextColor,
                      fontFamily: 'SF-Pro-Display-Regular',
                      fontSize: 20),),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          if (state is CategoryProductSuccess) {
            categoryProductList = state.categoryProductList!;
            // pageCount = (productList.length / rowsPerPage).ceilToDouble();
            // _productBloc!.add(OnUpdatePageCnt(productList: productList, rowsPerPage: rowsPerPage));
          }
          if (state is CategoryProductLoading) {
            // flagNoDataAvailable = false;
          }

          if (state is CategoryProductFail) {
            // flagNoDataAvailable = true;
          }
          // if(state is ProductPageCntSucess){
          //   pageCount=state.PageCnt;
          // }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              child:
              // (categoryProductList.isNotEmpty) ?
              buildProductList(context, categoryProductList)
              // : const Center(child: Text("No Data")),
            ),
          );
        }),
      ));


  }

  Widget buildProductList(
      BuildContext context, List<ProductModel> productList) {
    if (productList.length <= 0) {
      return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/2.5,
        ),
        // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      CachedNetworkImage(
                        // width: 150,
                        // height: 150,
                        filterQuality: FilterQuality.medium,
                        // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                        imageUrl: "https://picsum.photos/250?image=9",
                        // imageUrl: productData.prodImg.toString(),
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Theme.of(context).hoverColor,
                            highlightColor: Theme.of(context).highlightColor,
                            enabled: true,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
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
                            highlightColor: Theme.of(context).highlightColor,
                            enabled: true,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10, right: 5),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: ThemeColors.textColor,
                                    fontSize: 15.0,
                                    fontFamily: 'SF-Pro-Display-Regular'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "\u{20B9} 0.0",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                    fontFamily: 'SF-Pro-Display-Bold'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\u{20B9} 0.0",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                        fontFamily: 'SF-Pro-Display-Regular',
                                        color: ThemeColors.textFieldHintColor),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CartPage()));
                                      },
                                      child: Icon(
                                        Icons.add_shopping_cart,
                                        color: ThemeColors.baseThemeColor,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
              ),
            ),
          );
        },
        itemCount: List.generate(10, (index) => index).length,
      );
    }

    // return ListView.builder(
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/2.5,
      ),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return buildProductCard(context, productList[index]);
      },
      itemCount: productList.length,
    );
  }

  Widget buildProductCard(BuildContext context,ProductModel productList) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(productData: productList,)));
      },
      child: Container(
        height: 500,
        padding: new EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),
              CachedNetworkImage(
                // width: 150,
                // height: 150,
                filterQuality: FilterQuality.medium,
                // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                // imageUrl: "https://picsum.photos/250?image=9",
                imageUrl: productList.prodImg.toString(),
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).hoverColor,
                    highlightColor: Theme.of(context).highlightColor,
                    enabled: true,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
                    highlightColor: Theme.of(context).highlightColor,
                    enabled: true,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.error),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 5),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productList.prodName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ThemeColors.textColor,
                            fontSize: 15.0,
                            fontFamily: 'SF-Pro-Display-Regular'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\u{20B9} ${productList.discountPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            fontFamily: 'SF-Pro-Display-Bold'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\u{20B9} ${productList.price}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                fontFamily: 'SF-Pro-Display-Regular',
                                color: ThemeColors.textFieldHintColor),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartPage()));
                              },
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: ThemeColors.baseThemeColor,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}