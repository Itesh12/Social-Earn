import 'package:gainup/admin/screens/add_update_faqs/sr_add_update_faqs.dart';
import 'package:gainup/admin/screens/banners/sr_add_banners.dart';
import 'package:gainup/admin/screens/banners/sr_banners.dart';
import 'package:gainup/admin/screens/notification/sr_add_notification.dart';
import 'package:gainup/admin/screens/update_about/sr_update_about.dart';
import 'package:gainup/admin/screens/update_happy_clients/sr_update_happy_clients.dart';
import 'package:gainup/admin/screens/update_privacy_policy/sr_update_privacy.dart';
import 'package:gainup/admin/screens/update_terms/sr_update_terms.dart';
import 'package:gainup/core/routes/routes.dart';
import 'package:gainup/src/screens/about_us/sr_about_us.dart';
import 'package:gainup/src/screens/auth/forgot/forgot_binding.dart';
import 'package:gainup/src/screens/auth/forgot/sr_forgot.dart';
import 'package:gainup/src/screens/auth/login/login_binding.dart';
import 'package:gainup/src/screens/auth/login/sr_login.dart';
import 'package:gainup/src/screens/auth/signup/signup_binding.dart';
import 'package:gainup/src/screens/auth/signup/sr_signup.dart';
import 'package:gainup/src/screens/auth/user/sr_user.dart';
import 'package:gainup/src/screens/auth/user/sr_user_detail.dart';
import 'package:gainup/src/screens/auth/verify_email/sr_verify_email.dart';
import 'package:gainup/src/screens/dashboard/sr_dashboard.dart';
import 'package:gainup/src/screens/faqs/sr_faqs.dart';
import 'package:gainup/src/screens/full_image/sr_full_image.dart';
import 'package:gainup/src/screens/happy_clients/sr_happy_clients.dart';
import 'package:gainup/src/screens/home/sr_home.dart';
import 'package:gainup/src/screens/notification/sr_notification.dart';
import 'package:gainup/src/screens/past_trades/sr_past_trades.dart';
import 'package:gainup/src/screens/privacy_policy/sr_privacy_policy.dart';
import 'package:gainup/src/screens/pro/sr_pro.dart';
import 'package:gainup/src/screens/profile/sr_profile.dart';
import 'package:gainup/src/screens/saved/sr_saved.dart';
import 'package:gainup/src/screens/settings/sr_settings.dart';
import 'package:gainup/src/screens/splash/sr_splash.dart';
import 'package:gainup/src/screens/terms_and_conditions/sr_terms_and_conditions.dart';
import 'package:gainup/src/screens/trades/sr_final_trade.dart';
import 'package:gainup/src/screens/trades_type/sr_trade_types_list.dart';
import 'package:get/get.dart';

class Pages {
  static List<GetPage> pageList = [
    GetPage(name: Routes.INIT, page: () => SplashScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.ABOUTUS, page: () => AboutUsScreen()),
    GetPage(name: Routes.ADDBANNER, page: () => AddBannersScreen()),
    GetPage(name: Routes.ADDNOTIFICATION, page: () => AddNotificationScreen()),
    GetPage(name: Routes.BANNER, page: () => BannersScreen()),
    GetPage(name: Routes.DASHBOARD, page: () => DashboardScreen()),
    GetPage(name: Routes.EMAILVEIFY, page: () => VerifyEmailScreen()),
    GetPage(name: Routes.FAQ, page: () => FaqsScreen()),
    GetPage(name: Routes.EMAILVEIFY, page: () => VerifyEmailScreen()),
    GetPage(name: Routes.FINALTRADE, page: () => FinalTradeScreen()),
    GetPage(
      name: Routes.FORGOTPASSWORD,
      page: () => ForgotPasswordScreen(),
      bindings: [ForgotBinding()],
    ),
    GetPage(name: Routes.HAPPYCLIENTS, page: () => HappyClientsScreen()),
    GetPage(name: Routes.FULLIMAGE, page: () => FullImageScreen()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(name: Routes.NOTIFICATION, page: () => NotificationScreen()),
    GetPage(name: Routes.PASTTRADE, page: () => PastTradeScreen()),
    GetPage(name: Routes.PRIVACYPOLICY, page: () => PrivacyPolicyScreen()),
    GetPage(name: Routes.PRO, page: () => ProScreen()),
    GetPage(name: Routes.SAVED, page: () => SavedScreen()),
    GetPage(name: Routes.SETTINGS, page: () => SettingsScreen()),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
      bindings: [SignupBinding()],
    ),
    GetPage(
        name: Routes.TERMSANDCONDITION, page: () => TermsAndConditionScreen()),
    GetPage(name: Routes.TRADETYPE, page: () => TradesTypesListScreen()),
    GetPage(name: Routes.UPDATEABOUT, page: () => UpdateAboutScreen()),
    GetPage(name: Routes.ADDHAPPYCLIENT, page: () => AddHappyClientsScreen()),
    GetPage(name: Routes.UPDATEPRIVACY, page: () => UpdatePrivacyScreen()),
    GetPage(name: Routes.UPDATETERMS, page: () => UpdateTermsScreen()),
    GetPage(name: Routes.USERDETAILS, page: () => UserDetailsScreen()),
    GetPage(name: Routes.ADDFAQ, page: () => AddUpdateFaqsScreen()),
    GetPage(name: Routes.PROFILE, page: () => ProfileScreen()),
    GetPage(name: Routes.USERS, page: () => UserScreen()),
  ];
}
