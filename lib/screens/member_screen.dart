import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberLoginPage extends StatefulWidget {
  @override
  _MemberLoginPageState createState() => _MemberLoginPageState();
}

class _MemberLoginPageState extends State<MemberLoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.orange, // Change this to your desired color
    ));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 0, right: 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  Image.asset('images/logoheader.jpeg'),
                  SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: Text(
                        'Are you a member?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, '/voucherlogin_screen');
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              width: 80,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                    'NO',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        GestureDetector(
                          onTap: () {
                            checkLoginStatus().then((isLoggedIn) => {
                                  isLoggedIn
                                      ? Navigator.popAndPushNamed(
                                          context, '/home_screen')
                                      : Navigator.popAndPushNamed(
                                          context, '/login_screen')
                                });
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              width: 80,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                    'YES',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> checkLoginStatus() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
  return isLoggedIn;
}
