import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unstoppable_customer_app/Screen/Login/sign_in.dart';

import '../../Config/image.dart';
import '../../Constant/font_size.dart';
import '../../Constant/theme_colors.dart';


class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  // LoginBloc? _userLoginBloc;
  bool isconnectedToInternet = false;


  ListItem? supplierValue;
 final _formKey = GlobalKey<FormState>();
 final _firstNameController = TextEditingController();
 final _lastNameController = TextEditingController();

 final _mobNoController = TextEditingController();
 final _emailController = TextEditingController();





  void initState(){
    super.initState();

    // _userLoginBloc = BlocProvider.of<LoginBloc>(context);



  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _mobNoController.clear();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child:
        // BlocBuilder<LoginBloc,LoginState>(builder: (context,login){
        //   return BlocListener<LoginBloc,LoginState>(listener: (context,state){
        //     if(state is VendorRegistrationLoading){
        //     }
        //     if(state is VendorRegistrationSuccess)
        //     {
        //       Fluttertoast.showToast(msg: "Registered Successfully");
        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInPage()));
        //
        //     }
        //   },
        //     child: ,
        //   );
        // })
        Form(
          key: _formKey,
          child: Container(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height:150,
                  width: 300,
                  child: Image.asset('assets/images/Logo.png'),

                ),
                const SizedBox(height: 10,),
                Center(
                  child: Container(
                    width: 325,
                    // height: 270,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child:
                    Card(
                      color: ThemeColors.cardColor,
                      shape:  const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      elevation: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Align(alignment: Alignment.bottomLeft,
                              child: Text("Register Here",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight:FontWeight.bold
                                ),),
                            ),
                            const SizedBox(height: 15,),


                            //First Name

                            const Align(alignment: Alignment.topLeft,
                                child: Text("First Name:", textAlign: TextAlign.start,)),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _firstNameController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  hintStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: Colors.black)),
                                  hintText: "First Name",
                                ),
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please enter First Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if ( _formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 15,),

                            //Last Name
                            const Align(alignment: Alignment.topLeft,
                                child: Text("Last Name:", textAlign: TextAlign.start,)),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _lastNameController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  hintStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: Colors.black)),
                                  hintText: "Last Name",
                                ),
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please enter Last Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if ( _formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 15,),


                            //Mobile No:
                            const Align(alignment: Alignment.topLeft,
                                child: Text("Mobile No:", textAlign: TextAlign.start,)),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _mobNoController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  hintStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: Colors.black)),
                                  hintText: "+91 **********",
                                ),
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please Enter Mobile No';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if ( _formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 15,),

                            //Email:
                            const Align(alignment: Alignment.topLeft,
                                child: Text("Email:", textAlign: TextAlign.start,)),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _emailController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  hintStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    borderSide:
                                    BorderSide(width: 0.8, color: Colors.black),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: Colors.black)),
                                  hintText: "example@gmail.com",
                                ),
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if ( _formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 15,),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ThemeColors.drawerTextColor,
                            ),
                            onPressed: () async{
                              // isconnectedToInternet = await ConnectivityCheck
                              //     .checkInternetConnectivity();
                              // if (isconnectedToInternet == true) {
                              //   if(_nameController==null){
                              //     Fluttertoast.showToast(msg: "Please enter name");
                              //   }
                              //   else if(categoryModelselected==null){
                              //     Fluttertoast.showToast(msg: "Please select category");
                              //   }else if(subcategoryModelselected==null){
                              //     Fluttertoast.showToast(msg: "Please select sub category");
                              //   }else if(subsubcategoryModelselected==null){
                              //     Fluttertoast.showToast(msg: "Please select sub sub category");
                              //   }else if(_businessController==null){
                              //     Fluttertoast.showToast(msg: "Please enter business name");
                              //   }else if(_ownershipController==null){
                              //     Fluttertoast.showToast(msg: "Please enter ownership type");
                              //   }else if(_establishmentController==null){
                              //     Fluttertoast.showToast(msg: "Please enter year of establishment");
                              //   }else if(_totalEmpController==null){
                              //     Fluttertoast.showToast(msg: "Please enter total number of employees");
                              //   }else if(_annualTurnController==null){
                              //     Fluttertoast.showToast(msg: "Please enter annual turnover");
                              //   }else if(_gSTNController==null){
                              //     Fluttertoast.showToast(msg: "Please enter GSTN Number");
                              //   }else if(_BusinessAddressController==null){
                              //     Fluttertoast.showToast(msg: "Please enter business address");
                              //   }else if(_pinController==null){
                              //     Fluttertoast.showToast(msg: "Please enter pin code");
                              //   }
                              //   else if(_mobNoController==null){
                              //     Fluttertoast.showToast(msg: "Please enter mobile number");
                              //   }else if(_emailController==null){
                              //     Fluttertoast.showToast(msg: "Please enter email");
                              //   }
                              //   else
                              //   if (_formKey.currentState!.validate()) {
                              //     // Fluttertoast.showToast(msg: "Registered Successfully");
                              //
                              //     _userLoginBloc!.add(OnRegistration(
                              //       userType: _value,
                              //       fullName: _nameController.text,
                              //       businessName: _businessController.text,
                              //       catId: categoryModelselected!.catId.toString(),
                              //       subId: subcategoryModelselected!.subcatId.toString(),
                              //       subSubId: subsubcategoryModelselected!.sscatId.toString(),
                              //       ownershipType: _ownershipController.text,
                              //       estYear: _establishmentController.text,
                              //       totalEmp: _totalEmpController.text,
                              //       annualTurnover: _annualTurnController.text,
                              //       gSTIN: _gSTNController.text,
                              //       address: _BusinessAddressController.text,
                              //       pinCode: _pinController.text,
                              //       mobile: _mobNoController.text,
                              //       email: _emailController.text,
                              //       comLogo: _image!.path,
                              //       referby: _referBy.text,
                              //     ));
                              //   }
                              //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavigation()));
                              //
                              // } else {
                              //   CustomDialogs.showDialogCustom(
                              //       "Internet",
                              //       "Please check your Internet Connection!",
                              //       context);
                              // }

                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )

                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Already User?",style: TextStyle(fontWeight: FontWeight.normal),),
                    SizedBox(width: 8,),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInPage()));
                      },
                      child: Text("Login", style: TextStyle(color: ThemeColors.drawerTextColor, fontSize: FontSize.medium,fontWeight: FontWeight.bold),),),


                  ],
                ),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }

}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}