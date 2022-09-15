import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Constant/theme_colors.dart';
import '../Widget/app_button.dart';
import '../image_file.dart';

class MyProfile extends StatefulWidget {
  MyProfile({
    Key? key,
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



  //method to open gallery
  _openGallery(BuildContext context) async {

    final image = await picker.getImage(source: ImageSource.gallery,imageQuality: 25);
    imageFile=new ImageFile();
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
        imageFile!.imagePath=_image!.path;
      });
      // Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    imageFile=new ImageFile();
  }

  void dispose(){
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

            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios,color: ThemeColors.whiteTextColor),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(color: ThemeColors.whiteTextColor),
                ),

                // myAppBarIcon(),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                                : Image.network(
                                    "https://picsum.photos/250?image=9",
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
                          icon:
                          Icon(
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
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Align(alignment: Alignment.topLeft, child: Text("Name",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF-Pro-Display-Regular'
                              ),)),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                // initialValue: companyData![0].name.toString(),
                                controller: _nameController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration:  InputDecoration(
                                  hintText: "name",
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),

                                ),
                                validator: (value) {
                                  // profile.name = value!.trim();
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex =
                                  // new RegExp(pattern.toString());
                                  if(value==null || value.isEmpty){
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
                                    if ( _formKey.currentState!.validate()) {}

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
                              Align(alignment: Alignment.topLeft, child: Text("Mobile Number",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'
                                  )
                              )),
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
                                decoration:  InputDecoration(
                                  hintText: "Mobile Number",
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),

                                ),
                                validator: (value) {
                                  // profile.name = value!.trim();
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex =
                                  // new RegExp(pattern.toString());
                                  if(value==null || value.isEmpty){
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
                                    if ( _formKey.currentState!.validate()) {}

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
                              Align(alignment: Alignment.topLeft, child: Text("Email",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'
                                  ))),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                // initialValue: companyData![0].name.toString(),
                                controller: _emailController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration:  InputDecoration(
                                  hintText: "Email",
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),

                                ),
                                validator: (value) {
                                  // profile.name = value!.trim();
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex =
                                  // new RegExp(pattern.toString());
                                  if(value==null || value.isEmpty){
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
                                    if ( _formKey.currentState!.validate()) {}

                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      AppButton(
                        onPressed: () async {},
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        text: 'Update',
                        // loading: login is LoginLoading,
                        disableTouchWhenLoading: true,
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
