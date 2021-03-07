import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/screens/PaymentScreen.dart';
import 'package:future_choice_test_flutter/screens/birthday_screen.dart';
import 'package:future_choice_test_flutter/screens/destination_wedding_screen.dart';
import 'package:future_choice_test_flutter/screens/events_screen.dart';
import 'package:future_choice_test_flutter/screens/feedback_screen.dart';
import 'package:future_choice_test_flutter/screens/pre_wedding_screen.dart';
import 'package:future_choice_test_flutter/screens/profile_screen.dart';
import 'package:future_choice_test_flutter/screens/splash_screen.dart';
import 'package:future_choice_test_flutter/screens/vacations_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:future_choice_test_flutter/screens/about_us_screen.dart';
import 'package:future_choice_test_flutter/screens/amc_screen.dart';
import 'package:future_choice_test_flutter/screens/available_resorts.dart';
import 'package:future_choice_test_flutter/screens/book_holiday_screen.dart';
import 'package:future_choice_test_flutter/screens/contact_us_screen.dart';
import 'package:future_choice_test_flutter/screens/forgot_password.dart';
import 'package:future_choice_test_flutter/screens/gallery_screen.dart';
import 'package:future_choice_test_flutter/screens/login_screen.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:future_choice_test_flutter/screens/home_screen.dart';
import 'package:future_choice_test_flutter/screens/change_password.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn= await checkLoginStatus();

  runApp(MaterialApp(
    home: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Circular',
        primaryColor:primaryColor
      ),
      routes: {
        '/': (ctx)=>isLoggedIn?HomePage():LoginPage() ,
        '/login_screen':(ctx)=>LoginPage(),
        '/home_screen':(ctx)=>HomePage(),
        '/resorts_screen':(ctx)=>AvailableResorts(),
        '/book_holiday':(ctx) =>BookHoliday(),
        '/forgot_password':(ctx)=>ForgotPassword(),
        '/change_password':(ctx)=>ChangePassword(),
        '/amc_screen':(ctx)=>AmcScreen(),
        '/gallery_screen':(ctx)=>GalleryScreen(),
        '/about_us':(ctx)=> AboutUs(),
        '/contact_us':(ctx)=>ContactUs(),
        '/events':(ctx)=>EventsScreen(),
        '/preWedding':(ctx)=>PreWeddingScreen(),
        '/birthday_screen':(ctx)=>BirthdayScreen(),
        '/destinationWedding':(ctx)=>DestinationWedding(),
        '/feedback_screen':(ctx)=>FeedBackScreen(),
        '/vacations':(ctx)=>VacationsScreen(),
        '/payment':(ctx)=>PaymentScreen(),
        '/profile':(ctx)=>ProfileScreen()

      },
    ),
  ));
}

Future<bool> checkLoginStatus() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLoggedIn= sharedPreferences.getBool("isLoggedIn") ?? false;
  return isLoggedIn;
}

