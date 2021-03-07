import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:future_choice_test_flutter/screens/home_screen.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _passwordVisible=false;
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey= GlobalKey<ScaffoldState>();
  TextEditingController _textUserNameController=TextEditingController();
  TextEditingController _textPasswordController=TextEditingController();

  bool _isLoading=false;


    void loginUser(String username,String password) async{
    String url="http://www.futurechoiceclub.com/api/LoginApi/GetSignin?FullName=$username&Password=$password";
  http.Response response= await http.get(url);
  if(response.statusCode==200) {
    Map responseData = json.decode(response.body);
    setState(() {
      _isLoading = false;

    });
    if (responseData['Status'] == 1) {
      //showSnackBar(responseData['Fullname']);
       Fluttertoast.showToast(msg: "Welcome ${responseData['Fullname']}", toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1);
      setLoginStatus(true,responseData['User_Id'],responseData['Fullname'],responseData['Email']);
      Navigator.popAndPushNamed(context, '/home_screen');
    } else {
     
      Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }else{
    Fluttertoast.showToast(msg: "Something went wrong", toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset('images/logoheader.png'),
                SizedBox(
                  height: 50,
                ),
              TextFormField(
                controller: _textUserNameController,
                validator: (value){
                  if(value.isEmpty){
                    return 'Required';
                  }else{
                    return null;
                  }
                },
              keyboardType: TextInputType.text ,
              decoration:InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1,color: primaryColor)
              ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: primaryColor)
                ),
              ),
                textInputAction: TextInputAction.next,
              ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: !_passwordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                    controller: _textPasswordController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Required";
                    }else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: primaryColor)
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1,color: primaryColor)
                      )
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    if(formKey.currentState.validate()){
                      setState(() {
                        _isLoading=true;
                      });
                      loginUser(_textUserNameController.text,_textPasswordController.text);
                    }else{

                    }
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      width: 200,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login',style: TextStyle(color: Colors.white),),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 20,
                                height: 20,
                                margin: EdgeInsets.only(left: 10),
                                child:
                            _isLoading?CircularProgressIndicator(
                              valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                            ):Container()),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20,top: 10),
                      child: Text('Forgot Password?',style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(String username) {
    Flushbar(
      message: 'Welcome $username',
    ).show(context);
  }

}

setLoginStatus(bool loginStatus,int userId,String userName,String email) async{
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  sharedPreferences.setBool("isLoggedIn", loginStatus);
  sharedPreferences.setInt("userId",userId);
  sharedPreferences.setString("userName",userName);
  sharedPreferences.setString("userEmail",email);
}

