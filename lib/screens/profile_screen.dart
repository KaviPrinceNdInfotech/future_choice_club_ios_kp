import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

 List listProfileData;
 int userId;

 void getProfileData () async{
   var endPointUrl="https://www.futurechoiceclub.com/api/Myprofileapi/MyProfileGet";
   print(userId.toString());
   Map<String,String> queryParamete = {
     'id': userId.toString(),
   };
   String queryString= Uri(queryParameters: queryParamete).query;
   var requestUrl = endPointUrl + '?' + queryString;
   // var uri =
   // Uri.https('https://www.futurechoiceclub.com', '/api/Myprofileapi/MyProfileGet', queryParameters);
    http.Response response= await http.get(requestUrl);
    //print(requestUrl);
    //print('https://www.futurechoiceclub.com/api/Myprofileapi/MyProfileGet?id=$userId');
    //print(response.body);
    if(response.statusCode==200){
      setState(() {
        listProfileData= json.decode(response.body);

      });
    }else{
      Fluttertoast.showToast(msg: "No data available", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
              title: Text('Profile Details',style: TextStyle(color: Colors.white,fontSize: 16),),
        ),
      body: listProfileData==null?Center(
        child: CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ):Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                child: Card(
                    elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Basic Info',style: TextStyle(
                            color: primaryColor
                          ),),
                        ),
                        Divider(color: Colors.grey[400],
                        thickness: .5,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('Full Name'),
                          flex: 1,
                        ),
                        Expanded(flex:2,child: Text(listProfileData[0]['Name'],textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.grey[600],fontSize: 13
                        ),))
                      ],
                    ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Email'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['EMail'],maxLines:2,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13,
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Phone'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['Mobile'],textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Address'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['Address'],maxLines:3,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Membership Details',style: TextStyle(
                              color: primaryColor
                          ),),
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Type'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['TypeOfMembership'],textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Amc'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['Amc'],maxLines:2,textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.grey[600],fontSize: 13,
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Tenure'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text("${listProfileData[0]['Tenure']} Years",textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Date of joining'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['DOjoining'],maxLines:3,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Occupancy'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['Occumancy'],maxLines:3,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Amount'),
                              flex: 1,
                            ),
                            Expanded(flex:2,child: Text(listProfileData[0]['Amount'].toString(),maxLines:3,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.grey[600],fontSize: 13
                            ),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(5),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Special Offer',style: TextStyle(
                            color: primaryColor
                        ),),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                        Text(listProfileData[0]['SpecialOffer'],maxLines: 5,),
                        Divider(color: Colors.grey[400],
                          thickness: .5,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

  }

 void getUserId() async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   setState(() {
     userId= sharedPreferences.getInt("userId");

   });
   getProfileData();
 }

}
