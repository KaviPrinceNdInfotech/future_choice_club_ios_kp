import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/models/Resorts.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelDetails extends StatelessWidget {
  final Resorts resorts;
  const HotelDetails({Key key, this.resorts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          resorts.desinationName,
          style: GoogleFonts.roboto(
              fontSize: size.height * 0.02, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(LOCATION_IMAGE_BASE_URL + resorts.image),
              fit: BoxFit.fill,
            )),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  resorts.placeName,
                  style: GoogleFonts.aBeeZee(
                      backgroundColor: Colors.blueGrey,
                      fontSize: size.height * 0.014,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(resorts.description),
          ),
        ],
      ),
    );
  }
}
