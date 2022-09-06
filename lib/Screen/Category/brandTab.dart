
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BrandTab extends StatefulWidget {

  BrandTab({Key? key,}) : super(key: key);

  @override
  State<BrandTab> createState() => _BrandTabState();
}

class _BrandTabState extends State<BrandTab> {


  Widget buildBrandList(){
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(10, (index) {
        return Card(
          elevation: 4,
          child: Center(
            child: CachedNetworkImage(
              filterQuality: FilterQuality.medium,
              // imageUrl: Api.PHOTO_URL + widget.users.avatar,
              // imageUrl: "https://picsum.photos/250?image=9",
              imageUrl: "https://picsum.photos/250?image=9",
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
            )
          ),
        );
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height ,

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildBrandList(),
          ),
        ),
      ),
    );
  }

}