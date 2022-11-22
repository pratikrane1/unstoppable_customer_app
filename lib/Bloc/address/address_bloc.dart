
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unstoppable_customer_app/Model/banner_model.dart';
import '../../Model/address_model.dart';
import '../../Model/category_list.dart';
import '../../Model/product_model.dart';
import '../../Repository/UserRepository.dart';
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc({this.addressRepo}) : super(InitialAddressState());
  final UserRepository? addressRepo;


  @override
  Stream<AddressState> mapEventToState(event) async* {

    ///Get address list
    if (event is GetAddressList) {
      ///Notify loading to UI
      yield AddressListLoading();

      ///Fetch API via repository
      final AddressRepo response = await addressRepo!
          .fetchAddressList(
          user_id: event.user_id
      );

      print(response);

      final Iterable refactorProduct = response.result ?? [];
      final addressList = refactorProduct.map((item) {
        return AddressModel.fromJson(item);
      }).toList();
      if (refactorProduct.length > 0) {
        yield AddressListSuccess(message: response.msg.toString(), addressList: addressList);
      } else {
        yield AddressListfail(message: response.msg.toString());
      }
    }



    ///Add Address
    if (event is AddAddress) {
      ///Notify loading to UI
      yield AddAddressLoading();

      ///Fetch API via repository
      final AddAddressRepo result = await addressRepo!
          .addAddress(
          user_id: event.user_id,
        streetAddress: event.streetAddress,
        city: event.city,
        state: event.state,
        pincode: event.pinCode
      );

      print(result);

      if (result.status == true) {
        ///Login API success
        //  CustomerLogin user = CustomerLogin.fromJson(result.data);
        // CustomerLogin user = new CustomerLogin();
        // user.status = result.data!.status.toString();
        // user = result.data!;
        // AppBloc.authBloc.add(OnSaveUser(user));
        try {
          yield AddAddressSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield AddAddressfail(message: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield AddAddressfail(message: result.msg.toString());
      }
    }


    /// Edit address
    if (event is EditAddress) {
      ///Notify loading to UI
      yield EditAddressLoading();

      ///Fetch API via repository
      final AddAddressRepo result = await addressRepo!
          .editAddress(
          id: event.id,
          user_id: event.user_id,
          streetAddress: event.streetAddress,
          city: event.city,
          state: event.state,
          pincode: event.pinCode
      );

      print(result);

      if (result.status == true) {
        ///Login API success
        //  CustomerLogin user = CustomerLogin.fromJson(result.data);
        // CustomerLogin user = new CustomerLogin();
        // user.status = result.data!.status.toString();
        // user = result.data!;
        // AppBloc.authBloc.add(OnSaveUser(user));
        try {
          yield EditAddressSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield EditAddressfail(message: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield EditAddressfail(message: result.msg.toString());
      }
    }


    ///Delete Address
    if (event is DeleteAddress) {
      ///Notify loading to UI
      yield DeleteAddressLoading();

      ///Fetch API via repository
      final AddAddressRepo result = await addressRepo!
          .deleteAddress(
          user_id: event.user_id,
          id: event.id
      );

      print(result);

      if (result.status == true) {
        ///Login API success
        //  CustomerLogin user = CustomerLogin.fromJson(result.data);
        // CustomerLogin user = new CustomerLogin();
        // user.status = result.data!.status.toString();
        // user = result.data!;
        // AppBloc.authBloc.add(OnSaveUser(user));
        try {
          yield DeleteAddressSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield DeleteAddressfail(message: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield DeleteAddressfail(message: result.msg.toString());
      }
    }








  }



}
