class Images {
  static const String splash = "assets/images/splash.png";
  static const String backgroung = "assets/images/BG.png";


  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
