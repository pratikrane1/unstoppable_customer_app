import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unstoppable_customer_app/Bloc/authentication/authentication_event.dart';

import '../../Bloc/address/address_bloc.dart';
import '../../Bloc/address/address_event.dart';
import '../../Bloc/address/address_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/address_model.dart';
import '../../Utils/application.dart';
import '../../app_bloc.dart';
import 'add_address.dart';


class Address extends StatefulWidget {
  // UserProfileRepo? profileData;
  Address({
    Key? key,
    // required this.profileData
  }) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  dynamic addressLabel = '';

  AddressBloc? _addressBloc;
  List<AddressModel> addressData = [];
  AddressModel? data;
  late bool editAddress;
  @override
  void initState() {
    super.initState();
    _addressBloc = BlocProvider.of<AddressBloc>(context);
    _addressBloc!.add(GetAddressList(user_id: Application.customerLogin!.userId.toString()));;
 
  }


  Future<Null> _onRefresh() {
    setState(() {
      _addressBloc!.add(GetAddressList(user_id: Application.customerLogin!.userId.toString()));;
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }


  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // mainHeight = MediaQuery.of(context).size.height;
    // mainWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "My Address",
            style: TextStyle(color: ThemeColors.whiteTextColor),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: ThemeColors.whiteTextColor),
          ),
          
        ),
        body: BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
          return BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state is AddressListSuccess) {
                  addressData = state.addressList!;
                  // setData(companyData!);
                }


                if (state is AddressListLoading) {
                  // profileData = [];
                  // setData(companyData!);
                }

                //
                if (state is AddressListfail) {
                  // profileData = [];
                  // setData(companyData!);
                }
                if(state is DeleteAddressSuccess){
                  Fluttertoast.showToast(
                      msg: state.message.toString());
                  _onRefresh();
                }
              },

              child:  addressData != null ?
              RefreshIndicator(
                onRefresh: _onRefresh,
                strokeWidth: 3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),

                          child: Column(
                            children: <Widget>[
                              addressData.length>0 ?
                              Container(
                                  child: ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: addressData.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01,
                                              left: width * 0.04,
                                              right: width * 0.04,
                                              bottom: height * 0.01),
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black12)),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Radio(
                                                    value: addressData[index].id.toString(),
                                                    activeColor: Colors.pink,
                                                    focusColor: Colors.white,
                                                    groupValue: addressLabel,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        addressLabel = value!;
                                                      });
                                                      AppBloc.authBloc.add(OnSaveAddress(addressData[index]));

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                  width: width * 0.62,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        addressLabel =addressData[index].city.toString();
                                                      });

                                                      // addressController
                                                      //     .addAddress(
                                                      //     addressLabel,
                                                      //     addressList
                                                      //         .address[index]
                                                      //         .address,
                                                      //     addressList
                                                      //         .address[index]
                                                      //         .lat,
                                                      //     addressList
                                                      //         .address[index]
                                                      //         .long);
                                                      // Get.off(CheckoutPage());
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          child: Text(addressData[index].streetAddress.toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                        fontFamily: 'SF-Pro-Display-Regular',
                                                              color: Color(
                                                                  0Xff3f3639),
                                                              fontSize:
                                                              width * 0.04,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: width * 0.82,
                                                          child: Text(addressData[index].city.toString()+', '+addressData[index].state.toString()+', '+addressData[index].pincode.toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                        fontFamily: 'SF-Pro-Display-Medium',
                                                              color: Color(
                                                                  0Xffaaa4a6),
                                                              fontSize:
                                                              width * 0.032,
                                                            ),
                                                            overflow:
                                                            TextOverflow.fade,
                                                            maxLines: 2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage(addressData: addressData[index], editAddress: true,)));

                                                    },
                                                    child: Container(
                                                      child: Icon(Icons.edit,
                                                          color: ThemeColors
                                                              .baseThemeColor,
                                                          size: 25),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  InkWell(
                                                    onTap: () {
                                                     _addressBloc!.add(DeleteAddress(
                                                         user_id: Application.customerLogin!.userId.toString(),
                                                         id: addressData[index].id.toString()));

                                                    },
                                                    child: Container(
                                                      child: Icon(Icons.delete,
                                                          color: ThemeColors
                                                              .baseThemeColor,
                                                          size: 25),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      })) : Container(),
                              SizedBox(
                                height: 50,
                              ),

                              Container(
                                width: width,
                                height: 60.0,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: width * 0.20,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage(editAddress: false)));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                color: ThemeColors.baseThemeColor,
                                              ),
                                              onPressed: null),
                                        ),
                                        Container(
                                          child: Text(
                                            "Add New Address",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ThemeColors.baseThemeColor,
                                              fontSize: width * 0.04,
                                                fontFamily: 'SF-Pro-Display-Regular',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ))
                    ],
                  ),
                ),


              ) : Center(child: CircularProgressIndicator(),)

            // Center(
            //   child: CircularProgressIndicator(),
            // )


          );
        }
        )

            

    );
  }
}
