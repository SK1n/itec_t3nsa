part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const cameraPage = _Paths.cameraPage;
  static const resultsPage = home + _Paths.resultsPage;
}

abstract class _Paths {
  static const home = '/home';
  static const cameraPage = '/cameraPage';
  static const resultsPage = '/resultsPage';
}
