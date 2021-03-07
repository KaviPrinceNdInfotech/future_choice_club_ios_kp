import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';

class AmcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('AMC Details',style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.orange[800],
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                Expanded(
                  flex:1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: Text('Year',style: TextStyle(color: Colors.white),)),
                  ),
                ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 1.5,
                    width: 20
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(10),
                          child: Text('Amount',style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],

              ),

            ),
            Container(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex:1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: Text('1',style: TextStyle(color: Colors.black),)),
                    ),
                  ),
                  VerticalDivider(
                      color: Colors.white,
                      thickness: 1.5,
                      width: 20
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('10618 Rs (Including Gst)',style: TextStyle(color: Colors.black),)),
                    ),
                  )
                ],

              ),

            ),
            SizedBox(height: 10,),
            Container(
                padding: EdgeInsets.all(5),
                child: Text('In case of any due/over due of AMC/ Maintenance fee members will not be allowed to process any holidays')),
            SizedBox(height: 10,),
            Container(
                padding: EdgeInsets.all(5),
                child: Text('Pay your entire AMC and avail special discount, gift hampers and more'))
          ],
        ),
      ),
    );
  }
}
