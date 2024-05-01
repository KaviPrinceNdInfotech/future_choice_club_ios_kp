import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/models/Resorts.dart';
import 'package:future_choice_test_flutter/screens/hotel_details.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
    _isLoading = true;
    getResorts().then((value) {
      setState(() {
        resorts = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.blue.shade500,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Available Resorts',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: resorts == null
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ))
            : ListView.builder(
                itemCount: resorts.length,
                itemBuilder: (context, index) {
                  Resorts resort = resorts[index];

                  return Container(
                    margin: EdgeInsets.all(0),
                    child: Card(
                      child: ListTile(
                        trailing: Icon(Icons.arrow_circle_right),
                        title: Text(
                          resort.desinationName,
                          style: GoogleFonts.aBeeZee(
                              fontSize: size.width * 0.043,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade800),
                        ),
                        subtitle: Text(
                          resort.placeName,
                          style: GoogleFonts.aBeeZee(
                              fontSize: size.width * 0.033,
                              //fontWeight: FontWeight.bold,
                              color: Colors.green.shade800),
                        ),
                        onTap: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelDetails(resort)));*/
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  HotelDetails(resorts: resort)));
                        },
                      ),
                    ),
                  );
                }));
  }
}

Future<List<Resorts>> getResorts() async {
  final url = "https://fcclub.co.in/api/AssociateResort/GetAssociateResort";
  //"https://fcclub.co.in/api/AssociateResort/GetAssociateResort?id=77";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<Resorts> resorts = resortsFromJson(response.body);
    return resorts;
  } else {
    return List<Resorts>();
  }
}
