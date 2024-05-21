import 'package:music_app/utils/headers.dart';
import 'package:music_app/views/storage_page.dart';

class Routes {
  static const String splash = '/';
  static const String home = 'home';
  static const String storage = 'storage';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomePage(),
    storage: (context) => const StoragePage(),
  };
}
