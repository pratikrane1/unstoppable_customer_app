
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../Api/api.dart';
import '../../Bloc/category/category_bloc.dart';
import '../../Bloc/category/category_event.dart';
import '../../Bloc/category/category_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/category_list.dart';
import '../../NetworkFunction/fetchCategory.dart';
import '../Home/category_screen.dart';


class CategoriesTab extends StatefulWidget {

  CategoriesTab({Key? key,}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {

  List<CategoryModel> categoriesList = [];
  late CategoryModel catModel;
  CategoryBloc? _CategoryBloc;
  int per_page = 10;
  int start_from = 1;
  double pageCount = 0;
  bool showLoadingIndicator = false;
  bool flagNoDataAvailable=false;
  bool loading = true;
  ScrollController scrollController = ScrollController();

  bool _isSearching=false;

  // 1
  final _pagingController = PagingController<int, dynamic>(
    // 2
    firstPageKey: 1,
  );

  void initState() {
    // TODO: implement initState
    super.initState();
    _CategoryBloc = BlocProvider.of<CategoryBloc>(context);

    fetchData(start_from);
    handleNext();

  }

  void fetchData(start_from) async {
    setState(() {
      loading = true;
    });

    final params = {"per_page":per_page.toString(),
            "start_from":start_from.toString()};

          final response = await http.post(
              Uri.parse(Api.CATEGORIES),
              body: params
          );


    CategoryRepo modelClass = CategoryRepo.fromJson(json.decode(response.body));
    final Iterable refactorCategory = modelClass.result ?? [];
    final listCategory = refactorCategory.map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    categoriesList = categoriesList + listCategory;
    int localOffset = start_from + 1;
    if (!mounted) {
      return;
    }
    setState(() {
      categoriesList;
      loading = false;
      start_from = localOffset;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchData(start_from);
      }
    });
  }




  @override
  void dispose() {
    // 4
    // _controller.dispose();
    super.dispose();
  }



  // Widget buildCategoryList(
  //     BuildContext context, List<CategoryModel> cateboriesList) {
  //   if (categoriesList.length <= 0) {
  //     return ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
  //       itemBuilder: (context, index) {
  //         return Shimmer.fromColors(
  //           baseColor: Theme.of(context).hoverColor,
  //           highlightColor: Theme.of(context).highlightColor,
  //           enabled: true,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Container(
  //               width: MediaQuery.of(context).size.width,
  //               child: ListTile(
  //                 contentPadding: EdgeInsets.zero,
  //                 //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
  //                 // leading: nameIcon(),
  //                 leading: CachedNetworkImage(
  //                   filterQuality: FilterQuality.medium,
  //                   // imageUrl: Api.PHOTO_URL + widget.users.avatar,
  //                   imageUrl: "https://picsum.photos/250?image=9",
  //                   // imageUrl: model.cart[index].productImg == null
  //                   //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
  //                   //     : model.cart[index].productImg,
  //                   placeholder: (context, url) {
  //                     return Shimmer.fromColors(
  //                       baseColor: Theme.of(context).hoverColor,
  //                       highlightColor: Theme.of(context).highlightColor,
  //                       enabled: true,
  //                       child: Container(
  //                         height: 80,
  //                         width: 80,
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                   imageBuilder: (context, imageProvider) {
  //                     return Container(
  //                       height: 80,
  //                       width: 80,
  //                       decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                           image: imageProvider,
  //                           fit: BoxFit.cover,
  //                         ),
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     );
  //                   },
  //                   errorWidget: (context, url, error) {
  //                     return Shimmer.fromColors(
  //                       baseColor: Theme.of(context).hoverColor,
  //                       highlightColor: Theme.of(context).highlightColor,
  //                       enabled: true,
  //                       child: Container(
  //                         height: 80,
  //                         width: 80,
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                         child: Icon(Icons.error),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //                 title: Column(
  //                   children: [
  //                     Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: Text(
  //                         "Loading...",
  //                         overflow: TextOverflow.clip,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 15.0,
  //                           //color: Theme.of(context).accentColor
  //                         ),
  //                       ),
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Text(
  //                               ".......",
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.normal,
  //                                 color: Colors.black87,
  //                                 fontSize: 14.0,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: 20,
  //                             )
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(20)),
  //                   color: Colors.white),
  //             ),
  //           ),
  //         );
  //       },
  //       itemCount: List.generate(8, (index) => index).length,
  //     );
  //   }
  //
  //   // return ListView.builder(
  //   // return ListView.builder(
  //   //   scrollDirection: Axis.vertical,
  //   //   padding: EdgeInsets.only(top: 10, bottom: 20),
  //   //   itemCount: _posts.length,
  //   //   controller: _controller,
  //   //   itemBuilder: (context, index) {
  //   //     return categoriesCard(context, _posts[index]);
  //   //   },
  //   //
  //   // );
  // }

  Future<Null> _onRefresh() {
    setState(() {
      _CategoryBloc!.add(OnLoadingCategoryList(
        per_page:per_page,
        start_from:start_from,
      ));
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }


  @override
  Widget build(BuildContext context ) {
    // TODO: implement build
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: categoriesList.isNotEmpty ?
          categoriesList.length > 0 ? ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 10, bottom: 20),
            itemCount: categoriesList.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index == categoriesList.length) {
                return loading
                    ? Container(
                  height: 200,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                    ),
                  ),
                )
                    : Container();
              }
              return categoriesCard(context, categoriesList[index]);
            },

          ):
          const Align(
            alignment: Alignment.center,
            child: Text("No data",
              style: TextStyle(
                fontFamily: "SF-Pro-Display-Bold",
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),),
          ):ListView.builder(
          scrollDirection: Axis.vertical,
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
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    // leading: nameIcon(),
                    leading: CachedNetworkImage(
                      filterQuality: FilterQuality.medium,
                      // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                      imageUrl: "https://picsum.photos/250?image=9",
                      // imageUrl: model.cart[index].productImg == null
                      //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
                      //     : model.cart[index].productImg,
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
                            borderRadius: BorderRadius.circular(8),
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
                    title: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Loading...",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              //color: Theme.of(context).accentColor
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  ".......",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black87,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ],
                        ),
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
          itemCount: List.generate(8, (index) => index).length,
        ),
          // BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          //   if (state is CategoryListSuccess) {
          //     categoriesList = state.CategoryList!;
          //     _posts = categoriesList;
          //     // fetchedPosts = state.CategoryList!;
          //    // pageCount = (productList.length / rowsPerPage).ceilToDouble();
          //     // _productBloc!.add(OnUpdatePageCnt(productList: productList, rowsPerPage: rowsPerPage));
          //   }
          //   if (state is CategoryLoading) {
          //     flagNoDataAvailable = false;
          //   }
          //
          //   if (state is CategoryListLoadFail) {
          //     flagNoDataAvailable = true;
          //   }
          //
          //   return _isFirstLoadRunning ?
          //   Center(child: CircularProgressIndicator(),)
          //   : buildCategoryList(context, _posts);
          //
          //   // Column(
          //     //   children: [
          //     //     if (_isLoadMoreRunning == true)
          //     //       const Padding(
          //     //         padding: EdgeInsets.only(top: 10, bottom: 40),
          //     //         child: Center(
          //     //           child: CircularProgressIndicator(),
          //     //         ),
          //     //       ),
          //     //
          //     //     if (_hasNextPage == false)
          //     //       Container(
          //     //         padding: const EdgeInsets.only(top: 30, bottom: 40),
          //     //         color: Colors.amber,
          //     //         child: const Center(
          //     //           child: Text('You have fetched all of the content'),
          //     //         ),
          //     //       ),
          //     //   ],
          //     // );
          // }),
        ));


  }

  Widget categoriesCard(BuildContext context,CategoryModel categoryModel){
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(catData: categoryModel)));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // collapsedBackgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
              trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: ThemeColors.baseThemeColor),
              leading: CachedNetworkImage(
                filterQuality: FilterQuality.medium,
                // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                 imageUrl: categoryModel.ssCatImg.toString(),
               // imageUrl: "https://picsum.photos/250?image=9",
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
                      borderRadius: BorderRadius.circular(8),
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
              title: Text(
                categoryModel.ssCatName.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins-SemiBold',
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          // if (_isLoadMoreRunning == true)
          //   const Padding(
          //     padding: EdgeInsets.only(top: 10, bottom: 40),
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
          //
          // if (_hasNextPage == false)
          //   Container(
          //     padding: const EdgeInsets.only(top: 30, bottom: 40),
          //     color: Colors.amber,
          //     child: const Center(
          //       child: Text('You have fetched all of the content'),
          //     ),
          //   ),
        ],
      ),
    );
  }

}