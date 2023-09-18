import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;

class DestinationWedding extends StatefulWidget {
  @override
  _DestinationWeddingState createState() => _DestinationWeddingState();
}

class _DestinationWeddingState extends State<DestinationWedding> {
  List _listImages;
  Future getDestinationWeddingImages() async {
    http.Response response = await http
        .get('https://fcclub.co.in/api/Destinationapi/DestinationWedding');
    if (response.statusCode == 200) {
      setState(() {
        _listImages = json.decode(response.body);
        if (_listImages.isEmpty) {
          Fluttertoast.showToast(
              msg: "No Images available",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      });
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
          title: Text(
            'Destination Wedding',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: _listImages == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            : ListView.builder(
                itemCount: _listImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 400,
                    child: Image.network(
                      IMAGE_BASE_URL + _listImages[index]['ImageDest'],
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ));
  }

  @override
  void initState() {
    super.initState();
    getDestinationWeddingImages();
  }
}
