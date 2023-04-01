import 'package:pigeon/pigeon.dart';

class LandmarkPigeons {
  String? path;
}

@HostApi()
abstract class LandmarkPigeonsApi {
  String? getLandmark(String path);
}
