import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unstoppable_customer_app/Screen/Login/sign_in.dart';
import 'package:unstoppable_customer_app/Utils/connectivity_check.dart';
import 'package:unstoppable_customer_app/Widget/app_button.dart';
import 'package:unstoppable_customer_app/Widget/app_dialogs.dart';

import '../../Bloc/login/login_bloc.dart';
import '../../Bloc/login/login_event.dart';
import '../../Bloc/login/login_state.dart';
import '../../Config/image.dart';
import '../../Constant/font_size.dart';
import '../../Constant/theme_colors.dart';
import '../bottom_navbar.dart';


class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
   LoginBloc? _userLoginBloc;
  bool isconnectedToInternet = false;
  bool loading = true;


  ListItem? supplierValue;
 final _formKey = GlobalKey<FormState>();
 final _fnameController = TextEditingController();
 final _lnameController = TextEditingController();
 final _mobNoController = TextEditingController();
 final _emailController = TextEditingController();





  void initState(){
    super.initState();
    _userLoginBloc = BlocProvider.of<LoginBloc>(context);
    loading;

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fnameController.clear();
    _lnameController.clear();
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
                   margin: EdgeInsets.all(15.0),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Register Here",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                fontFamily: 'SF-Pro_display'
                              ),),
                            const SizedBox(height: 15,),


                            //First Name

                            Text("First  Name:",style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w400,fontFamily: 'SF-Pro_display'),),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                                    fontSize: 14.0,color: ThemeColors.textColor),
                                controller: _fnameController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,

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
                            Text("Last Name:", style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w400,fontFamily: 'SF-Pro_display'),),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _lnameController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                                    fontSize: 14.0,color: ThemeColors.textColor),
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
                            Text("Mobile No:",style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w400,fontFamily: 'SF-Pro_display'),),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _mobNoController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                                    fontSize: 14.0,color: ThemeColors.textColor),
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
                            Text("Email:", style: TextStyle(fontSize: 12.0,
                                fontWeight: FontWeight.w400,fontFamily: 'SF-Pro_display'),),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width ,
                              child: TextFormField(
                                controller: _emailController,
                                obscureText: false,
                                //initialValue: widget.userdata['name'],
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                                    fontSize: 14.0,color: ThemeColors.textColor),
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


                BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, signup) {
                      return BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is CustomerRegistrationSuccess) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                            Fluttertoast.showToast(msg: state.msg);
                            loading = false;

                          }

                          if (state is CustomerRegistrationFail) {
                            Fluttertoast.showToast(msg: state.msg);
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AppButton(
                              loading: loading,
                              onPressed: () async {
                                isconnectedToInternet =
                                await ConnectivityCheck
                                    .checkInternetConnectivity();
                                if (isconnectedToInternet == true) {
                                  if (_fnameController == null) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter first name");
                                  }
                                  else if (_mobNoController == null) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter mobile number");
                                  } else if (_emailController == null) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter email");
                                  }else if (_lnameController == null) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter last name");
                                  }
                                 else
                                  if (_formKey.currentState!.validate()) {
                                    _userLoginBloc!.add(OnRegistration(
                                      fname: _fnameController.text,
                                      mobileNo: _mobNoController.text,
                                      email: _emailController.text,
                                      lname: _lnameController.text,
                                    ));
                                  }
                                } else {
                                  CustomDialogs.showDialogCustom(
                                      "Internet",
                                      "Please check your Internet Connection!",
                                      context);
                                }
                              },
                              text: 'Register',
                            )

                        ),
                      );
                    }
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Already User?",style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'SF-Pro-Display',fontSize: 14.0),),
                    SizedBox(width: 8,),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInPage()));
                      },
                      child: Text("Login", style: TextStyle(color: ThemeColors.drawerTextColor,
                          fontSize: 14.0,fontFamily:'SF-Pro-Display',fontWeight: FontWeight.w600),),),


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