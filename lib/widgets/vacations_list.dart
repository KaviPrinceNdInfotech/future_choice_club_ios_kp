import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';

class VacationListItem extends StatelessWidget {
  final int index;
  final String dateString;
  final int tenure;
  final int days;
  final int nights;

  const VacationListItem(
      this.index, this.dateString, this.tenure, this.days, this.nights);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: [
                Image.asset(
                  'images/price_tag.png',
                  height: 30,
                  width: 55,
                ),
                Positioned(
                  top: 8,
                  left: 22,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: primaryColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getDateInString(0),
                    style: TextStyle(fontSize: 13),
                  ),
                  Text((int.parse(getDateInString(2)) + index).toString(),
                      style: TextStyle(fontSize: 13, color: Colors.black)),
                  Text(getDateInString(1).toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      )),
                ],
              ),
            ),
            Image.asset(
              'images/arrow_final.png',
              width: 60,
              height: 40,
              color: primaryColor,
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: primaryColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getDateInString(0),
                    style: TextStyle(fontSize: 13),
                  ),
                  Text((int.parse(getDateInString(2)) + 1 + index).toString(),
                      style: TextStyle(fontSize: 13)),
                  Text(getDateInString(1), style: TextStyle(fontSize: 13))
                ],
              ),
            ),
            Text(
              (() {
                if ((int.parse(getDateInString(2)) + index) ==
                    getCurrentYear()) {
                  return '$nights Night \n and \n $days Days';
                } else {
                  return '6 Night \n and \n 7 Days';
                }
              }()),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/book_holiday');
                      },
                      child: Visibility(
                          visible:
                              (int.parse(getDateInString(2)) + index + 1) ==
                                  getCurrentYear(),
                          child: Image.asset(
                            'images/play.png',
                            width: 50,
                            height: 25,
                            color: primaryColor,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/feedback_screen');
                      },
                      child: Visibility(
                          visible: (int.parse(getDateInString(2)) + index + 1) <
                              getCurrentYear(),
                          child: Image.asset(
                            'images/feedback.png',
                            width: 50,
                            height: 25,
                          )),
                    ),
                    Visibility(
                        visible: (int.parse(getDateInString(2)) + index + 1) >
                            getCurrentYear(),
                        child: Icon(
                          Icons.event_available,
                          size: 30,
                          color: Colors.green,
                        )),
                  ],
                ),
                Text(
                  (() {
                    if ((int.parse(getDateInString(2)) + index + 1) ==
                        getCurrentYear()) {
                      return 'Book now';
                    } else if ((int.parse(getDateInString(2)) + index + 1) <
                        getCurrentYear()) {
                      return 'Feedback';
                    } else if ((int.parse(getDateInString(2)) + index + 1) >
                        getCurrentYear()) {
                      return 'Available';
                    }
                  }()),
                  style: TextStyle(
                      fontSize: 10,
                      color: (() {
                        if ((int.parse(getDateInString(2)) + index + 1) ==
                            getCurrentYear()) {
                          return Colors
                              .yellow.shade900; // Change color for 'Book now'
                        } else if ((int.parse(getDateInString(2)) + index + 1) <
                            getCurrentYear()) {
                          return Colors.blue; // Change color for 'Feedback'
                        } else if ((int.parse(getDateInString(2)) + index + 1) >
                            getCurrentYear()) {
                          return Colors.green; // Change color for 'Available'
                        }
                      }()),
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //
  // String getDateInString(int index) {
  //   return dateString.split(" ")[index];
  // }
  String getDateInString(int index) {
    //List<String> dateParts = dateString.split(' ');
    return dateString.split(' ')[index];
  }

  int getCurrentYear() {
    var currentDate = DateTime.now();
    //print(currentDate.year);
    return currentDate.year;
  }
}
