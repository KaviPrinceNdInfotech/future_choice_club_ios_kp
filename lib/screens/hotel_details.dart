import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/models/Resorts.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:future_choice_test_flutter/screens/available_resorts.dart';

class HotelDetails extends StatelessWidget {
  final Resorts resorts;
  const HotelDetails({Key key, this.resorts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(LOCATION_IMAGE_BASE_URL + resorts.image),
          SizedBox(
            height: 10,
          ),
          Text(resorts.description),
        ],
      ),
    );
  }
}
