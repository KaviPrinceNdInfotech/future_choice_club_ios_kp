import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PreWeddingScreen extends StatefulWidget {
  @override
  _PreWeddingScreenState createState() => _PreWeddingScreenState();
}

class _PreWeddingScreenState extends State<PreWeddingScreen> {



  List _listImages;
  Future getPreWeddingImages() async{
    http.Response response = await http.get('https://www.futurechoiceclub.com/api/preWeddingapi/preWedding');
    if(response.statusCode==200){
      setState(() {
        _listImages=json.decode(response.body);
      });
    }else{
      Fluttertoast.showToast(msg: "Something went wrong", toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pre Wedding',style: TextStyle(color: Colors.white,fontSize: 16),),
        iconTheme: IconThemeData(
          color: Colors.white
      )
        ,
      ),

      body: _listImages==null?Center(
        child: CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ):ListView.builder(
        itemCount: _listImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 400,
            child:   Image.network(
              IMAGE_BASE_URL+_listImages[index]['ImageDest'],
              width: double.infinity,height: 400,fit: BoxFit.cover,),
          );
      },

      )
    );
  }

  @override
  void initState() {
    super.initState();
    getPreWeddingImages();
  }
}
