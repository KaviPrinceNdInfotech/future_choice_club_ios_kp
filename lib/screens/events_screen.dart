import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Events',style: TextStyle(color: Colors.white,fontSize: 16),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
                onTap: (){
              Navigator.pushNamed(context, '/preWedding');
                },
                child: Image.asset('images/pre_wedding.png')),
            GestureDetector(
                onTap: (){
                Navigator.pushNamed(context, '/birthday_screen');
                },
                child: Image.asset('images/birthday.png')),
            GestureDetector(
                onTap: (){
                    Navigator.pushNamed(context, '/destinationWedding');
                },
                child: Image.asset('images/destination_wedding.png'))
          ],
        ),
      ),
    );
  }
}
