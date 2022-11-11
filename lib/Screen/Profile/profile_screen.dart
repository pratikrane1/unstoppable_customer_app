import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unstoppable_customer_app/Screen/Login/sign_in.dart';
import 'package:unstoppable_customer_app/Screen/Profile/edit_profile.dart';
import 'package:unstoppable_customer_app/Widget/profile_shimmer.dart';
import '../../Api/api.dart';
import '../../Bloc/profile/profile_bloc.dart';
import '../../Bloc/profile/profile_event.dart';
import '../../Bloc/profile/profile_state.dart';
import '../../Config/image.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/user_profile_model.dart';
import '../../Utils/application.dart';
import '../../Widget/app_button.dart';
import '../../Widget/drawer.dart';
import '../../image_file.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyProfile extends StatefulWidget {
  // UserProfileRepo? profileData;
  MyProfile({
    Key? key,
    // required this.profileData
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  ImageFile? imageFile;
  final picker = ImagePicker();
  bool flagLoading = false;
  bool loading = true;

  ProfileBloc? _probileBloc;
  UserProfileRepo? profileData;

  //method to open gallery
  _openGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    imageFile = new ImageFile();
    if (image != null) {
      _cropImage(image);
    }
  }

  // For crop image

  Future<Null> _cropImage(PickedFile imageCropped) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageCropped.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          // CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
        ]
            : [
          // CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )) as File?;
    if (croppedFile != null) {
      setState(() {
        // mImageFile.image = croppedFile;
        // print(mImageFile.image.path);
        // state = AppState.cropped;
        _image = croppedFile;
        imageFile!.imagePath = _image!.path;
      });
      // Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    loading;
    _probileBloc = BlocProvider.of<ProfileBloc>(context);
    _probileBloc!.add(GetProfile(user_id: Application.customerLogin!.userId.toString()));;
  }



  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: ThemeColors.whiteTextColor),
        ),
        leading: GestureDetector(
          onTap: () {
          },
          child: Icon(Icons.arrow_back_ios, color: ThemeColors.baseThemeColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Application.preferences!.remove('user');
              // _RemoverUser();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                    (Route<dynamic> route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccess) {
                profileData = state.profileData;
                // setData(companyData!);
              }


              if (state is ProfileLoading) {
                // profileData = [];
                // setData(companyData!);
              }

              //
              if (state is Profilefail) {
                // profileData = [];
                // setData(companyData!);
              }
            },

            child:  profileData != null ?
            SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: ThemeColors.whiteTextColor,
                            child: ClipOval(
                              child: new SizedBox(
                                width: 150.0,
                                height: 150.0,
                                child: (_image != null)
                                    ? Image.file(
                                  _image!,
                                  fit: BoxFit.fill,
                                )
                                    : Image.asset(
                                  Images.profile_icon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //Name
                    profileData!.name == null ? Container() :
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          //Name
                          Container(
                            height: 40,
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.userTie,
                                color:
                                ThemeColors.baseThemeColor,
                                size: 26,
                              ),
                              title: Text(
                                profileData!.name.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),

                          //Address

                          Container(
                            height: 40,
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.streetView,
                                color:
                                ThemeColors.baseThemeColor,
                                size: 20,
                              ),
                              title: Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),


                          //Mobile No
                          profileData!.mobileNo == null ? Container() :
                          Container(
                            height: 40,
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.phoneAlt,
                                color:
                                ThemeColors.baseThemeColor,
                                size: 20,
                              ),
                              title: Text(
                                profileData!.mobileNo.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),


                          //Edit profile
                          GestureDetector(
                            child: Container(
                              height: 40,
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.userEdit,
                                  color: ThemeColors.baseThemeColor,
                                  size: 20,
                                ),
                                title: Text('Edit Profile',
                                    style: TextStyle(
                                        color: ThemeColors
                                            .baseThemeColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                                trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                    ThemeColors.baseThemeColor),
                              ),
                            ),
                            onTap: () {
                             Navigator.push(context, 
                             MaterialPageRoute(builder: (context)=> EditProfile(profileData: profileData,)));
                            },
                          ),

                          //Change Password
                          GestureDetector(
                            child: Container(
                              height: 40,
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.key,
                                  color: ThemeColors.baseThemeColor,
                                  size: 20,
                                ),
                                title: Text('Change Password',
                                    style: TextStyle(
                                        color: ThemeColors
                                            .baseThemeColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                                trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                    ThemeColors.baseThemeColor),
                              ),
                            ),
                            onTap: () {
                              // Get.to(() => EditPasswordPage())?.then(
                              //         (_) => profileController
                              //         .getUserProfile());
                            },
                          ),
                        ],
                      ),
                    ),


                  ],
                )

            ) : ProfileShimmer()

            // Center(
            //   child: CircularProgressIndicator(),
            // )


        );
      }
      )

    );
  }
}
