import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/models/Resorts.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AvailableResorts extends StatefulWidget {
  @override
  _AvailableResortsState createState() => _AvailableResortsState();
}

class _AvailableResortsState extends State<AvailableResorts> {

  List<Resorts> resorts;
  bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=true;
    getResorts().then((value) {
      setState(() {
        resorts=value;
        _isLoading=false;
      });

    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('Available Resorts',
            style: TextStyle(color: Colors.white, fontSize: 16),),
        ),
        body: resorts==null?Center(child: CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(primaryColor),
        )):ListView.builder(
            itemCount: resorts.length,
            itemBuilder: (context, index) {
              Resorts resort=resorts[index];

              return Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  child: ListTile(
                    title: Text(resort.desinationName),
                    subtitle: Text(resort.placeName),
                  ),
                ),
              );
            })
    );
  }

}

 Future<List<Resorts>> getResorts() async{
final url="https://www.futurechoiceclub.com/api/AssociateResort/GetAssociateResort?id=77";
final response = await http.get(url);
if(response.statusCode==200){
final List<Resorts> resorts= resortsFromJson(response.body);
return resorts;
}else{
  return List<Resorts>();
}
}





