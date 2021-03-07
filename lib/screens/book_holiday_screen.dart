import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/widgets/thanks_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookHoliday extends StatefulWidget {
  @override
  _BookHolidayState createState() => _BookHolidayState();
}

class _BookHolidayState extends State<BookHoliday> {

  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  bool _isLoading=false;
  int userId;
  List locationList;
  String selectedLocation;
  DateTime selectedDate = DateTime.now();

  TextEditingController _textNoOfNightsController=TextEditingController();
  TextEditingController _textNoOfAdultsController=TextEditingController();
  TextEditingController _textNoOfChildController=TextEditingController();
  TextEditingController _textMembershipIdController=TextEditingController();


  @override
  void initState() {
    super.initState();
        getUserId();
        getLocations();
        //print(selectedLocation);
  }

  Future getLocations() async{
    http.Response response= await http.get("http://futurechoiceclub.com/api/BookHoliday/AllCity");
    if(response.statusCode==200){
      setState(() {
        locationList=json.decode(response.body);
      });


    }else{
      Fluttertoast.showToast(msg: "Something went wrong", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: locationList==null?Center(
        child: CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ):Container(
        color: primaryColor,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset('images/logoheader.png'),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),

                ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30,left: 20),
                        width: double.infinity,
                        child: Text('Search Hotel',textAlign: TextAlign.start,
                        style: GoogleFonts.abhayaLibre(fontSize: 30,fontWeight: FontWeight.bold),)),
                    Container(
                      width: double.infinity,
                        margin: EdgeInsets.only(left: 20,top: 5),
                        child: Text('Find hotel as you need with demand',
                          textAlign: TextAlign.start,style: TextStyle(fontSize: 12,color: Colors.grey),)),
                    Container(
                      width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 20),
                        child: Text('Select City',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.start,)),
                    Container(
                      color: textInPutBackground,
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                        child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          value: selectedLocation,
                          style: TextStyle(color: Colors.black),
                          underline: Container(),
                          hint: Text('Select city'),
                          onChanged: (value) {
                            setState(() {
                              selectedLocation=value;
                              print(selectedLocation);
                            });

                        }, items:
                          locationList?.map((item)
                      {
                      return DropdownMenuItem(
                        value: item['DesinationName'],
                          child: Text(item['DesinationName']));
                      })?.toList()??[]
                        ,

                        )),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 20),
                        child: Text('Check in date',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.start,)),
                    GestureDetector(
                      onTap: (){
                        _selectDate(context);
                      },
                      child: Container(
                          color: textInPutBackground,
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                          child: Text("${selectedDate.toLocal()}".split(' ')[0],style: TextStyle(color: Colors.black),textAlign: TextAlign.start,)),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 20),
                        child: Text('No of Nights',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.start,)),
                    Container(
                      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                      decoration: BoxDecoration(
                        color: textInPutBackground,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _textNoOfNightsController,
                        validator: (value){
                          if(value.isEmpty){
                            return 'required';
                          }else{
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '10',
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: Text('No of Adults',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.start,)),
                    Container(
                      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                      decoration: BoxDecoration(
                          color: textInPutBackground,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _textNoOfAdultsController,
                        validator: (value){
                          if(value.isEmpty){
                            return 'required';
                          }else{
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: '2',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    Container(

                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: Text('No of Children',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.start,)),
                    Container(
                      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                      decoration: BoxDecoration(
                          color: textInPutBackground,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _textNoOfChildController,
                        validator: (value){
                          if(value.isEmpty){
                            return 'required';
                          }else{
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: '2',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: Text('Enter Membership Id',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.start,)),
                    Container(
                      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                      decoration: BoxDecoration(
                          color: textInPutBackground,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _textMembershipIdController,
                        validator: (value){
                          if(value.isEmpty){
                            return 'required';
                          }else{
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(formKey.currentState.validate()){
                          if(selectedLocation!=null){
                            setState(() {
                              _isLoading=true;
                            });
                            bookHoliday(context);

                          }else{
                            Fluttertoast.showToast(msg: "Select location please", toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1);
                          }
                        }
                      },
                      child: Container(
                        width: 240,
                        margin: EdgeInsets.only(bottom: 20),
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
                                Text('Book',style: TextStyle(color: Colors.white),),
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
                    )
                  ],
                ),
              ),
              )
            ],

          ),
        ),
      ),
    );
  }

  void bookHoliday(BuildContext context) async{
    Map data={
      'City':selectedLocation,
      'NoofNights':_textNoOfNightsController.text.toString(),
      'NoofAdults':_textNoOfAdultsController.text.toString(),
      'Noofchild':_textNoOfChildController.text.toString(),
      'CheckinDate':selectedDate.toString(),
      'UserId':userId.toString(),
      'MemberShipId':"adadadd"
    };
    String url="https://futurechoiceclub.com/api/BookHoliday/GetHoliday";
    http.Response response= await http.post(url,body: data);
    print(response.body);
    if(response.statusCode==200){
        Map responseData=json.decode(response.body);
        if(responseData['Status']==1){
          setState(() {
            _isLoading=false;
          });
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return ThanksDialog(context);
            },
          );
      }

    }else{
      Fluttertoast.showToast(msg: "Something went wrong", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }


  }

  void getUserId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId= sharedPreferences.getInt("userId");
    });
  }
}

