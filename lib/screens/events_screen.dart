import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:url_launcher/url_launcher.dart';

import 'easy_dinner_web.dart';

class EventsScreen extends StatefulWidget {
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse('https://1m6m.app.link/j7j8oLQD6Cb/');
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Events',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/preWedding');
                },
                child: Image.asset(
                  'images/pre_wedding.png',
                  height: 130,
                )),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/birthday_screen');
                },
                child: Image.asset('images/birthday.png')),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/destinationWedding');
                },
                child: Image.asset('images/destination_wedding.png')),
            GestureDetector(
                onTap: () {
                  // _launchUrl();
                  // Get.to(WebViewPswebsite());
                  print("clickioscscsc");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewEasydinner()),
                  );
                  // Navigator.pushNamed(context, '/WebViewEasydinner');
                },
                child: Image.asset('images/easydinner.jpeg'))
          ],
        ),
      ),
    );
  }
}
