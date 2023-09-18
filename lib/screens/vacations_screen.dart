import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:future_choice_test_flutter/widgets/vacations_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VacationsScreen extends StatefulWidget {
  @override
  _VacationsScreenState createState() => _VacationsScreenState();
}

class _VacationsScreenState extends State<VacationsScreen> {
  Map vacationsData;
  int userId;

  void getTenureDetails() async {
    var endPointUrl = "https://fcclub.co.in/api/BookHoliday/GetAllTaner";
    print(userId.toString());
    Map<String, String> queryParamete = {
      'userId': userId.toString(),
    };
    String queryString = Uri(queryParameters: queryParamete).query;
    var requestUrl = endPointUrl + '?' + queryString;
    http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['Status'] == 1) {
        setState(() {
          vacationsData = responseData;
        });
      } else {
        Fluttertoast.showToast(
            msg: "NO data found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Vacations',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: vacationsData == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : Container(
              child: ListView.builder(
                  itemCount: int.parse(vacationsData['Tenure']),
                  itemBuilder: (context, index) {
                    return VacationListItem(
                        index,
                        getDate(vacationsData['DOjoining']),
                        int.parse(vacationsData['Tenure']),
                        vacationsData['Days'],
                        vacationsData['Nights']);
                  }),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    //getTenureDetails();
  }

  String getDate(String date) {
    String finalMonth = "";
    List<String> dateList;
    if (date.contains('/')) {
      dateList = date.split('/');
    } else if (date.contains('-')) {
      dateList = date.split('/');
    }

    switch (dateList[1]) {
      case "1":
        {
          finalMonth = "Jan";
        }
        break;
      case "2":
        {
          finalMonth = "Feb";
        }
        break;
      case "3":
        {
          finalMonth = "Mar";
        }
        break;
      case "4":
        {
          finalMonth = "Apr";
        }
        break;
      case "5":
        {
          finalMonth = "May";
        }
        break;
      case "6":
        {
          finalMonth = "Jun";
        }
        break;
      case "7":
        {
          finalMonth = "Jul";
        }
        break;
      case "8":
        {
          finalMonth = "Aug";
        }
        break;
      case "9":
        {
          finalMonth = "Sep";
        }
        break;
      case "10":
        {
          finalMonth = "Oct";
        }
        break;
      case "11":
        {
          finalMonth = "Nov";
        }
        break;
      case "12":
        {
          finalMonth = "Dec";
        }
        break;
      case "01":
        {
          finalMonth = "Jan";
        }
        break;
      case "02":
        {
          finalMonth = "Feb";
        }
        break;
      case "03":
        {
          finalMonth = "Mar";
        }
        break;
      case "04":
        {
          finalMonth = "Apr";
        }
        break;
      case "05":
        {
          finalMonth = "May";
        }
        break;
      case "06":
        {
          finalMonth = "Jun";
        }
        break;
      case "07":
        {
          finalMonth = "Jul";
        }
        break;
      case "08":
        {
          finalMonth = "Aug";
        }
        break;
      case "09":
        {
          finalMonth = "Sep";
        }
        break;
    }

    return dateList[0] + " " + finalMonth + " " + dateList[2];
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("userId");
    });
    getTenureDetails();
  }
}
