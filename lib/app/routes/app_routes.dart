part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const resultsPage = home + _Paths.resultsPage;
  static const login = _Paths.login;
  static const signUp = login + _Paths.signUp;
  static const gallery = home + _Paths.gallery;
  static const fullscreen = _Paths.fullscren;
}

abstract class _Paths {
  static const home = '/home';
  static const resultsPage = '/resultsPage';
  static const login = '/login';
  static const signUp = "/signup";
  static const gallery = "/gallery";
  static const fullscren = "/fullscreen";
}
