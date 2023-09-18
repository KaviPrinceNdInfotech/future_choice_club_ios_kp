import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List _listImages;

  Future getGalleryImages() async {
    http.Response response =
        await http.get("https://fcclub.co.in/api/BookHoliday/AllImag");
    if (response.statusCode == 200) {
      setState(() {
        _listImages = json.decode(response.body);
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
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Gallery',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: _listImages == null
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ))
          : ListView.builder(
              itemCount: _listImages.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 400,
                  child: Image.network(
                    IMAGE_BASE_URL + _listImages[index]['ImageName'],
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                );
              }),
    );
  }

  @override
  void initState() {
    super.initState();
    getGalleryImages();
  }
}
