

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/authentication/authentication_bloc.dart';
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
  static final settingsBloc = SettingsBloc(settingsRepo: userRepository);
  static final categoryBloc = CategoryBloc(categoryRepo: userRepository);




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
    BlocProvider<SettingsBloc>(
      create: (context) => settingsBloc,
    ),
    BlocProvider<CategoryBloc>(
      create: (context) => categoryBloc,
    ),


  ];

  static void dispose() {
    // applicationBloc.close();
    // languageBloc.close();
    themeBloc.close();
    authBloc.close();
    loginBloc.close();
    profileBloc.close();
    categoryBloc.close();
    settingsBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
