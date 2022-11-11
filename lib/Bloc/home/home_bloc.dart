
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/product_model.dart';
import '../../Repository/UserRepository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.homeRepo}) : super(InitialHomeState());
  final UserRepository? homeRepo;


  @override
  Stream<HomeState> mapEventToState(event) async* {



    if (event is GetProduct) {
      ///Notify loading to UI
      yield ProductLoading();

      ///Fetch API via repository
      final ProductRepo response = await homeRepo!
          .fetchHomeProduct(
        limit: event.limit,
      );

      print(response);

      final Iterable refactorProduct = response.result ?? [];
      final profileData = refactorProduct.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
      if(refactorProduct.length>0){
        yield ProductSuccess(message: response.msg.toString(), productData: profileData);

      }else{
        yield Productfail(message: response.msg.toString());

      }

      // ///Case API fail but not have token
      // if (result.status == true) {
      //   // UserProfileRepo user = UserProfileRepo.fromJson(result.data);
      //   UserProfileRepo user = new UserProfileRepo();
      //   user.status = result.data!.status.toString();
      //   user = result.data!;
      //   // AppBloc.authBloc.add(OnSaveUser(user));
      //   try {
      //     ///Begin start AuthBloc Event AuthenticationSave
      //
      //     yield ProfileSuccess(message: result.msg.toString());
      //   } catch (error) {
      //     ///Notify loading to UI
      //     yield Profilefail(message: result.msg.toString());
      //   }
      // } else {
      //   ///Notify loading to UI
      //   yield Profilefail(message: result.msg.toString());
      // }


    }





  }



}
