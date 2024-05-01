import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:future_choice_test_flutter/widgets/thanks_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookHoliday extends StatefulWidget {
  @override
  _BookHolidayState createState() => _BookHolidayState();
}

class _BookHolidayState extends State<BookHoliday> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int userId;
  // String locationId = "224";

  ///item['DesinationName'],

  List locationList;
  String selectedLocation;

  //List<LocationModel> locationIdd = <LocationModel>[];

  /// LocationModel ? _locationModel

  List hotelList;
  String selectedHotel;

  DateTime selectedDate = DateTime.now();
  TextEditingController _textNoOfNightsController = TextEditingController();
  TextEditingController _textNoOfAdultsController = TextEditingController();
  TextEditingController _textNoOfChildController = TextEditingController();
  TextEditingController _textMembershipIdController = TextEditingController();

  //String Id;

  @override
  void initState() {
    super.initState();
    getUserId();
    //getLocationId();
    getLocations();

    /// getHotel();
    selectedHotel;
    locationList;
    hotelList;
    // selectedLocation.listen((p0) {
    //   if (p0 != null) {
    //     getCityByStateID("${p0.id}");
    //   }
    // });
    //print(selectedLocation);
  }

  ///todo: kumar prince.. location...13 feb 2024..
  Future getLocations() async {
    http.Response response =
        await http.get("https://fcclub.co.in/api/BookHoliday/AllCity");
    if (response.statusCode == 200) {
      setState(() {
        locationList = json.decode(response.body);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  ///todo: kumar prince.. location...13 feb 2024..
  // Modify getHotel method to accept locationId as a parameter
  Future getHotel(String locationId) async {
    http.Response response = await http.get(
        "https://fcclub.co.in/api/BookHoliday/GetPlaceByLocationId?LocationId=$locationId");
    print("okowss${locationId}");
    if (response.statusCode == 200) {
      print("okow${locationId}");
      setState(() {
        hotelList = json.decode(response.body);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  ///

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: locationList == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : SafeArea(
              child: Container(
                // backgroundColor: primaryColor,
                color: primaryColor,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: size.height * 0.3,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/logoheader.jpeg"),
                                fit: BoxFit.fitWidth)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.00,
                              horizontal: size.width * 0.028),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: size.width * 0.075,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black26,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: Colors.white,
                                    size: size.height * 0.02,
                                  ),
                                  // IconButton(
                                  //     color: Colors.white,
                                  //     onPressed: () {
                                  //       Navigator.pop(context);
                                  //     },
                                  //     icon: Icon(Icons.arrow_back_ios_outlined)),
                                ),
                              ),
                              //Container(child: Icon(Icons.arrow_back_ios_outlined))),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      ///Image.asset('images/logoheader.jpeg'),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                        ),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 30, left: 20),
                                  width: double.infinity,
                                  child: Text(
                                    'Search Hotel',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 20, top: 5),
                                  child: Text(
                                    'Find hotel as you need with demand',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Select City',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),

                              ///
                              Container(
                                  color: textInPutBackground,
                                  width: double.infinity,
                                  height: 50,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
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
                                        selectedLocation = value;
                                        selectedHotel = null;

                                        // Get the location ID based on its name
                                        String locationId = locationList
                                            .firstWhere((element) =>
                                                element['DesinationName'] ==
                                                value)['Id']
                                            .toString();
                                        print("fsafsaf ${locationId}");

                                        // Call the method to get hotels based on location ID
                                        getHotel(locationId);
                                      });
                                    },
                                    items: locationList?.map((item) {
                                          return DropdownMenuItem(
                                            value: item['DesinationName'],
                                            child: Text(
                                                item['DesinationName'] ?? " "),
                                          );
                                        })?.toList() ??
                                        [],
                                  )),

                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Select Hotel',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),

                              ///
                              Container(
                                  color: textInPutBackground,
                                  width: double.infinity,
                                  height: 50,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: DropdownButton(
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: selectedHotel,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(),
                                    hint: Text('Select Hotel'),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedHotel = value;
                                        print(selectedHotel);
                                      });
                                    },
                                    items: hotelList?.map((item) {
                                          // Check if hotelList is not null before mapping

                                          return DropdownMenuItem(
                                              value: item['PlaceName'] ?? " ",
                                              child: Text(
                                                  item['PlaceName'] ?? ""));
                                        })?.toList() ??
                                        [],
                                  )),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'Check in date',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                    color: textInPutBackground,
                                    width: double.infinity,
                                    height: 50,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child: Text(
                                      "${selectedDate.toLocal()}".split(' ')[0],
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.start,
                                    )),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'No of Nights',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: textInPutBackground,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _textNoOfNightsController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Text(
                                    'No of Adults',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: textInPutBackground,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _textNoOfAdultsController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Text(
                                    'No of Children',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: textInPutBackground,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _textNoOfChildController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Text(
                                    'Enter Membership Id',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: textInPutBackground,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  controller: _textMembershipIdController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (formKey.currentState.validate()) {
                                    if (selectedLocation != null) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      bookHoliday(context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Select location please",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1);
                                    }
                                  }
                                },
                                child: Container(
                                  width: 150,
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      width: 150,
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: Text(
                                                'Book Now',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                width: 15,
                                                height: 15,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: _isLoading
                                                    ? CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      )
                                                    : Container()),
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
            ),
    );
  }

  void bookHoliday(BuildContext context) async {
    Map data = {
      'City': selectedLocation,
      'PlaceName': selectedHotel,
      'NoofNights': _textNoOfNightsController.text.toString(),
      'NoofAdults': _textNoOfAdultsController.text.toString(),
      'Noofchild': _textNoOfChildController.text.toString(),
      'CheckinDate': selectedDate.toString(),
      'UserId': userId.toString(),
      'MemberShipId': _textMembershipIdController.text.toString(),
      //"adadadd"
    };
    String url = "https://fcclub.co.in/api/BookHoliday/GetHoliday";
    http.Response response = await http.post(url, body: data);
    print(response.body);
    print("okosdcsc: ${response.body}");

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      print("okosdcsc: ${response.body}");
      print("okosdcsczxxxz: $data");

      if (responseData['Status'] == 1) {
        setState(() {
          _isLoading = false;
        });
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return ThanksDialog(context);
          },
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("userId");
    });
  }

  // void getLocationId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String id = sharedPreferences.getString("Id");
  //   if (id != null) {
  //     setState(() {
  //       locationId = id;
  //     });
  //   } else {
  //     // Handle the case where the value is not found or null
  //     // For example, set a default value
  //     setState(() {
  //       locationId = "${224}";
  //
  //       /// "okok"; // Replace "default_value" with your desired default value
  //       print("okokolocation: ${locationId}");
  //     });
  //   }
  // }

  // void getLocationId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     locationId = sharedPreferences.getString("Id");
  //   });
  // }
}
