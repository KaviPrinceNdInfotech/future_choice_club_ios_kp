import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_choice_test_flutter/screens/PaymentScreen.dart';
import 'package:future_choice_test_flutter/screens/about_us_screen.dart';
import 'package:future_choice_test_flutter/screens/amc_screen.dart';
import 'package:future_choice_test_flutter/screens/available_resorts.dart';
import 'package:future_choice_test_flutter/screens/birthday_screen.dart';
import 'package:future_choice_test_flutter/screens/book_holiday_screen.dart';
import 'package:future_choice_test_flutter/screens/change_password.dart';
import 'package:future_choice_test_flutter/screens/contact_us_screen.dart';
import 'package:future_choice_test_flutter/screens/destination_wedding_screen.dart';
import 'package:future_choice_test_flutter/screens/emi_details.dart';
import 'package:future_choice_test_flutter/screens/events_screen.dart';
import 'package:future_choice_test_flutter/screens/feedback_screen.dart';
import 'package:future_choice_test_flutter/screens/forgot_password.dart';
import 'package:future_choice_test_flutter/screens/gallery_screen.dart';
import 'package:future_choice_test_flutter/screens/generatevoucher_screen.dart';
import 'package:future_choice_test_flutter/screens/home_screen.dart';
import 'package:future_choice_test_flutter/screens/login_screen.dart';
import 'package:future_choice_test_flutter/screens/member_screen.dart';
import 'package:future_choice_test_flutter/screens/payment_history.dart';
import 'package:future_choice_test_flutter/screens/pre_wedding_screen.dart';
import 'package:future_choice_test_flutter/screens/profile_screen.dart';
import 'package:future_choice_test_flutter/screens/splash_screen.dart';
import 'package:future_choice_test_flutter/screens/vacations_screen.dart';
import 'package:future_choice_test_flutter/screens/voucher_screen.dart';
import 'package:future_choice_test_flutter/screens/voucherregister_screen.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

///todo: edited by kumar prince till 1 july 2023...

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //bool isLoggedIn = await checkLoginStatus();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Circular', primaryColor: primaryColor),
    routes: {
      //'/': (ctx) => isLoggedIn ? HomePage() : LoginPage(),
      '/': (ctx) => SplashScreen(),
      '/memberlogin_screen': (ctx) => MemberLoginPage(),
      '/voucherlogin_screen': (ctx) => VoucherLoginPage(),
      '/voucherregister_screen': (ctx) => VoucherRegisterPage(),
      '/generatevoucher_screen': (ctx) => GenerateVoucherPage(),

      '/login_screen': (ctx) => LoginPage(),
      '/home_screen': (ctx) => HomePage(),
      '/resorts_screen': (ctx) => AvailableResorts(),
      '/book_holiday': (ctx) => BookHoliday(),
      '/forgot_password': (ctx) => ForgotPassword(),
      '/change_password': (ctx) => ChangePassword(),
      '/amc_screen': (ctx) => AmcScreen(),
      '/gallery_screen': (ctx) => GalleryScreen(),
      '/about_us': (ctx) => AboutUs(),
      '/contact_us': (ctx) => ContactUs(),
      '/events': (ctx) => EventsScreen(),
      '/preWedding': (ctx) => PreWeddingScreen(),
      '/birthday_screen': (ctx) => BirthdayScreen(),
      '/destinationWedding': (ctx) => DestinationWedding(),
      '/feedback_screen': (ctx) => FeedBackScreen(),
      '/vacations': (ctx) => VacationsScreen(),
      '/payment': (ctx) => PaymentScreen(),
      '/profile': (ctx) => ProfileScreen(),
      '/paymentHistory': (ctx) => PaymentHistory(),
      '/emi_details': (ctx) => EmiDetails()
    },
  ));
}

// Future<bool> checkLoginStatus() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   bool isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
//   return isLoggedIn;
// }
///todo: kumar prince........1 may  2024 after dropdown changed..latest
/// 2024..this is original code for development...fch
///
