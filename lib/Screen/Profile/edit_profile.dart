import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unstoppable_customer_app/Screen/Profile/profile_screen.dart';
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

import '../bottom_navbar.dart';


class EditProfile extends StatefulWidget {
  UserProfileRepo? profileData;
  EditProfile({
    Key? key,
    required this.profileData
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  ImageFile? imageFile;
  final picker = ImagePicker();
  bool flagLoading = false;
  bool loading = true;

  ProfileBloc? _userProfileBloc;
  // late Future<UserProfileRepo> profileData;


  // Future<UserProfileRepo> getUserProfile() async {
  //   var list;
  //
  //
  //   final  response = await http.post(
  //     Uri.parse(Api.HOST_URL+Api.GET_PROFILE),
  //     body: {"user_id":Application.customerLogin!.userId.toString()},
  //   );
  //   // if(response.statusCode == 200){
  //   //   final responseJson = json.decode(response.body);
  //   //   print(responseJson);
  //   //   return UserProfileRepo.fromJson(responseJson);
  //   // }
  //
  //   try{
  //     String respBody = response.body;
  //     final resp = json.decode(respBody);
  //     if(resp['status'] == true){
  //       list = resp['data'];
  //       print(list);
  //     }
  //     // else{
  //     //   list = resp['data'][0];
  //     // }
  //   }catch(e){
  //     print(e);
  //     rethrow;
  //   }
  //   // if (response.statusCode == 200) {
  //   //   final responseJson = json.decode(response.body)["data"];
  //   //   // // print(responseJson);
  //   //   data = responseJson;
  //   //   list = data[0];
  //   //   print(list);
  //   //   // listdata = list[0];
  //   //   // userId = listdata["3"];
  //   //   // print(listdata);
  //   //   // print("DATA $data");
  //   //   // print("DATA ${userData}");
  //   //   // final Iterable refactorProduct = data ?? [];
  //   //   // final userProfileData = refactorProduct.map((item) {
  //   //   //   return UserProfileModel.fromJson(item);
  //   //   // }).toList();
  //   //   // // print("Data $userProfileData");
  //   //   // return UserProfileRepo.fromJson(responseJson);
  //   //
  //   //
  //   // }
  //   return UserProfileRepo.fromJson(list);
  //
  // }

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

    imageFile = new ImageFile();
    loading;
    _userProfileBloc = BlocProvider.of<ProfileBloc>(context);
    setData();
  }

  setData() {
    if (widget.profileData != null) {
      _nameController.text = widget.profileData!.name.toString();
      _mobileController.text = widget.profileData!.mobileNo.toString();
      _emailController.text = widget.profileData!.email.toString();
    } else {
      _nameController.text = "";
      _mobileController.text = "";
      _emailController.text = "";
    }
  }

  void dispose() {
    super.dispose();
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Future getImage() async {
    //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   setState(() {
    //     _image = File(image!.path);
    //   });
    // }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 4,)));
          },
          child: Icon(Icons.arrow_back_ios, color: ThemeColors.whiteTextColor),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(color: ThemeColors.whiteTextColor),
                ),

                // myAppBarIcon(),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                  Positioned(
                    bottom: 5,
                    right: 8,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ThemeColors.buttonColor,
                      child: IconButton(
                        onPressed: () {
                          //image picker
                          // getImage();
                          _openGallery(context);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 25,
                          color: ThemeColors.whiteTextColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF-Pro-Display-Regular'),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        // initialValue: Application.customerLogin!.name.toString(),
                        controller: _nameController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: "name",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          hintStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                width: 0.8,
                                color: ThemeColors.textFieldBgColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                width: 0.8,
                                color: ThemeColors.textFieldBgColor),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  width: 0.8,
                                  color: ThemeColors.textFieldBgColor)),
                        ),
                        validator: (value) {
                          // profile.name = value!.trim();
                          // Pattern pattern =
                          //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          // RegExp regex =
                          // new RegExp(pattern.toString());
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          // else if(!regex.hasMatch(value)){
                          //   return 'Please enter valid name';
                          // }
                          return null;
                        },
                        onChanged: (value) {
                          // profile.name = value;
                          setState(() {
                            // _nameController.text = value;
                            if (_formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Mobile Number",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'))),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            // initialValue: companyData![0].name.toString(),
                            controller: _mobileController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                            ),
                            decoration: InputDecoration(
                              hintText: "Mobile Number",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              hintStyle: TextStyle(fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 0.8,
                                    color: ThemeColors.textFieldBgColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 0.8,
                                    color: ThemeColors.textFieldBgColor),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBgColor)),
                            ),
                            validator: (value) {
                              // profile.name = value!.trim();
                              // Pattern pattern =
                              //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              // RegExp regex =
                              // new RegExp(pattern.toString());
                              if (value == null || value.isEmpty) {
                                return 'Please enter Mobile Number';
                              }
                              // else if(!regex.hasMatch(value)){
                              //   return 'Please enter valid name';
                              // }
                              return null;
                            },
                            onChanged: (value) {
                              // profile.name = value;
                              setState(() {
                                // _nameController.text = value;
                                if (_formKey.currentState!.validate()) {}
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text("Email",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'SF-Pro-Display-Regular',
                                      )),
                                  SizedBox(width: 5,),
                                  Text("(Non Changable)",style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SF-Pro-Display-Regular',
                                      color: Colors.red
                                  ))
                                ],
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            readOnly: true,
                            // initialValue: "om@gmail.com",
                            controller: _emailController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                            ),
                            decoration: InputDecoration(
                              hintText: "Email",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              hintStyle: TextStyle(fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 0.8,
                                    color: ThemeColors.textFieldBgColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(
                                    width: 0.8,
                                    color: ThemeColors.textFieldBgColor),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBgColor)),
                            ),
                            validator: (value) {
                              // profile.name = value!.trim();
                              // Pattern pattern =
                              //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              // RegExp regex =
                              // new RegExp(pattern.toString());
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                              // else if(!regex.hasMatch(value)){
                              //   return 'Please enter valid name';
                              // }
                              return null;
                            },
                            onChanged: (value) {
                              // profile.name = value;
                              setState(() {
                                // _nameController.text = value;
                                if (_formKey.currentState!.validate()) {}
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, profileUpdate) {
                            return BlocListener<ProfileBloc, ProfileState>(
                                listener: (context, state) {
                                  if (state is ProfileUpdateSuccess) {
                                    // Navigator.of(context).pop();
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DrawerWidget()));
                                    Fluttertoast.showToast(
                                        msg: state.message.toString());
                                    loading = true;
                                  }
                                  if (state is ProfileUpdateLoading) {
                                    loading = false;
                                  }

                                  if (state is ProfileUpdatefail) {
                                    Fluttertoast.showToast(
                                        msg: state.message.toString());
                                    flagLoading = false;
                                  }
                                },
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AppButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            if (_nameController == null) {
                                              Fluttertoast.showToast(
                                                  msg: "Please enter name");
                                            } else if (_mobileController == null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Please enter mobile number");
                                            } else if (_emailController == null) {
                                              Fluttertoast.showToast(
                                                  msg: "Please enter email");
                                            } else if (_formKey.currentState!
                                                .validate()) {
                                              _userProfileBloc!.add(ProfileUpdate(
                                                user_id: Application.customerLogin!.userId.toString(),
                                                name: _nameController.text,
                                                mobileNo: _mobileController.text,
                                              ));
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please fill the data");
                                          }
                                        },
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        text: 'Update',
                                        loading: loading,
                                      )),
                                ));
                          })
                    ],
                  ),
                ),
              ),
            ),

          ],
        )
        // FutureBuilder<UserProfileRepo>(
        //   future: profileData,
        //   builder: (context, snapshot){
        //     if(snapshot.hasData){
        //      return ;
        //
        //     }
        //     else if(snapshot.hasError){
        //       Fluttertoast.showToast(msg: "${snapshot.error}");
        //     }
        //     return Center(child: CircularProgressIndicator(),);
        //   },
        // )

      ),
    );
  }
}
