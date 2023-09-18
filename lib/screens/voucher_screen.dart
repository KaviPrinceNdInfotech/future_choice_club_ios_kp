import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/models/VoucherData.dart';
import 'package:future_choice_test_flutter/screens/generatemovievoucher_screen.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;

class VoucherLoginPage extends StatefulWidget {
  final Voucher voucher;
  VoucherLoginPage({Key key, @required this.voucher}) : super(key: key);

  @override
  _VoucherLoginPageState createState() => _VoucherLoginPageState();
}

class _VoucherLoginPageState extends State<VoucherLoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  TextEditingController _textUserNameController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  void loginUser(String name) async {
    String url =
        "https://fcclub.co.in/api/Vacationapi/MatchPassword?password=" +
            _textUserNameController.text.toString();
    http.Response response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      setState(() {
        _isLoading = false;
      });
      if (responseData['Status'] == 1) {
        if (widget.voucher != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GenerateMovieVoucherPage(voucher: widget.voucher)));
        } else {
          Navigator.popAndPushNamed(context, '/voucherregister_screen');
        }
      } else {
        Fluttertoast.showToast(
            msg: "Incorrect username or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey1,
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset('images/logoheader.jpeg'),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: Text(
                        'Verify Password for voucher generation',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _textUserNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: primaryColor)),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey1.currentState.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        loginUser(_textUserNameController.text);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Something  ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1);
                      }

                      // if (widget.voucher != null) {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) =>
                      //           GenerateMovieVoucherPage(voucher: widget.voucher)));
                      // } else {
                      //   Navigator.popAndPushNamed(
                      //       context, '/voucherregister_screen');
                      // }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: 100,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              'Verify',
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
          ),
        ),
      ),
    );
  }
}
