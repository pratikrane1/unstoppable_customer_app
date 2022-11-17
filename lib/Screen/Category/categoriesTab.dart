
import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

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
  final TextEditingController _searchcontroller = TextEditingController();

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
    _CategoryBloc!.add(OnLoadingCategoryList(
        per_page:per_page,
         start_from:start_from,
    ));

    // 3
    _pagingController.addPageRequestListener((pageKey) {
      //_fetchPage(pageKey);
    });



  }



  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
  }



  Widget buildCategoryList(
      BuildContext context, List<CategoryModel> cateboriesList) {
    if (categoriesList.length <= 0) {
      return ListView.builder(
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
      );
    }

    // return ListView.builder(
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return categoriesCard(context, categoriesList[index]);
      },
      itemCount: categoriesList.length,
    );
  }

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
          child: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
            if (state is CategoryListSuccess) {
              categoriesList = state.CategoryList!;
             // pageCount = (productList.length / rowsPerPage).ceilToDouble();
              // _productBloc!.add(OnUpdatePageCnt(productList: productList, rowsPerPage: rowsPerPage));
            }
            if (state is CategoryLoading) {
              flagNoDataAvailable = false;
            }

            if (state is CategoryListLoadFail) {
              flagNoDataAvailable = true;
            }
            // if(state is ProductPageCntSucess){
            //   pageCount=state.PageCnt;
            // }
            return buildCategoryList(context,categoriesList);
          }),
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
      child: Padding(
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
    );
  }

}