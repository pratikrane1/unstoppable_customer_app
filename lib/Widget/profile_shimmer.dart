import 'package:flutter/material.dart';
import '../Config/image.dart';
import '../Constant/theme_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileShimmerState();
  }
}

class _ProfileShimmerState extends State<ProfileShimmer> {
  var mainHeight, mainWidth;
  String? phone, name, address;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        highlightColor: Colors.grey[400]!,
                        baseColor: Colors.grey[300]!,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: mainWidth / 3,
                          height: mainWidth / 3,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(Images.profile_icon),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Shimmer.fromColors(
                      highlightColor: Colors.grey[400]!,
                      baseColor: Colors.grey[300]!,
                      child: Container(
                        //margin: EdgeInsets.symmetric(vertical: 20),
                        height: mainHeight / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.withOpacity(.0),
                          image: DecorationImage(
                            image: AssetImage(Images.profile_icon),
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                highlightColor: Colors.grey[400]!,
                                baseColor: Colors.grey[300]!,
                                child: GestureDetector(
                                  onTap: () {
                                    print('name taped');
                                  },
                                  child: Container(
                                    height: 55,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.person,
                                        color: ThemeColors.baseThemeColor,
                                        size: 30,
                                      ),
                                      title: Text(
                                        "Customer..",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                highlightColor: Colors.grey[400]!,
                                baseColor: Colors.grey[300]!,
                                child: GestureDetector(
                                  onTap: () {
                                    print('location taped');
                                  },
                                  child: Container(
                                    height: 55,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.location_on_outlined,
                                        color: ThemeColors.baseThemeColor,
                                        size: 26,
                                      ),
                                      title: Text(
                                        "Location..",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                highlightColor: Colors.grey[400]!,
                                baseColor: Colors.grey[300]!,
                                child: GestureDetector(
                                  onTap: () {
                                    print('Phone taped');
                                  },
                                  child: Container(
                                    height: 55,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.phone_sharp,
                                        color: ThemeColors.baseThemeColor,
                                        size: 26,
                                      ),
                                      title: Text(
                                        "Phone no..",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ThemeColors.baseThemeColor;
    Path path = Path()
      ..relativeLineTo(0, 115)
      ..quadraticBezierTo(size.width / 2, 250, size.width, 120)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
