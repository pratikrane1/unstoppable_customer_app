

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unstoppable_customer_app/Bloc/contactUs/contactUs_event.dart';

import 'Bloc/authentication/authentication_bloc.dart';
import 'Bloc/contactUs/contactUs_bloc.dart';
import 'Bloc/category/category_bloc.dart';
import 'Bloc/login/login_bloc.dart';
import 'Bloc/profile/profile_bloc.dart';
import 'Bloc/changePassword/changePassword_bloc.dart';
import 'Bloc/theme/theme_bloc.dart';
import 'Repository/UserRepository.dart';

class AppBloc {
  static final userRepository = UserRepository();
  static final themeBloc = ThemeBloc();

  static final authBloc = AuthBloc(userRepository: userRepository);
  static final loginBloc = LoginBloc(userRepository: userRepository);
  static final profileBloc = ProfileBloc(profileRepo: userRepository);
  static final contactUsBloc = ContactUsBloc(contactUsRepo: userRepository);
  static final changePassBloc = ChangePassBloc(changePassRepo: userRepository);
  static final categoryBloc = CategoryBloc(categoryRepo: userRepository);
  static final homeBloc = HomeBloc(homeRepo: userRepository);




  static final List<BlocProvider> providers = [
    // BlocProvider<ApplicationBloc>(
    //   create: (context) => applicationBloc,
    // ),
    // BlocProvider<LanguageBloc>(
    //   create: (context) => languageBloc,
    // ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => profileBloc,
    ),
    BlocProvider<ContactUsBloc>(
      create: (context) => contactUsBloc,
    ),
    BlocProvider<ChangePassBloc>(
      create: (context) => changePassBloc,
    ),
    BlocProvider<CategoryBloc>(
      create: (context) => categoryBloc,
    ),
    BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
    ),


  ];

  static void dispose() {
    // applicationBloc.close();
    // languageBloc.close();
    themeBloc.close();
    authBloc.close();
    loginBloc.close();
    profileBloc.close();
    contactUsBloc.close();
    categoryBloc.close();
    changePassBloc.close();
    homeBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
