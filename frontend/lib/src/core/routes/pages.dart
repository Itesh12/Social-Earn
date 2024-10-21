import 'package:get/get.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/screen/auth/login/sr_login.dart';
import 'package:socialearn/src/screen/auth/register/sr_register.dart';
import 'package:socialearn/src/screen/community/create_community/sr_create_community.dart';
import 'package:socialearn/src/screen/home/sr_home.dart';
import 'package:socialearn/src/screen/splash/sr_splash.dart';

class Pages {
  static List<GetPage> pageList = [
    GetPage(name: Routes.INIT, page: () => SplashScreen()),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.CREATECOMMUNITY, page: () => CreateCommunityScreen()),
  ];
}
