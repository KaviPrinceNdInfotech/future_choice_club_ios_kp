import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      checkLoginStatus().then((isLoggedIn) =>{
          isLoggedIn?Navigator.popAndPushNamed(context, '/home_screen'):Navigator.popAndPushNamed(context, '/login_screen')
      } );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/logoheader.png'),
      ),
    );
  }
}

  Future<bool> checkLoginStatus() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLoggedIn= sharedPreferences.getBool("isLoggedIn") ?? false;
  return isLoggedIn;
}
