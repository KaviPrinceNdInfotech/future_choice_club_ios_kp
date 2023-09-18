import 'dart:convert';
import 'package:future_choice_test_flutter/screens/available_resorts.dart';
import 'package:future_choice_test_flutter/screens/hotel_details.dart';

List<Resorts> resortsFromJson(String str) =>
    List<Resorts>.from(json.decode(str).map((x) => Resorts.fromJson(x)));

String resortsToJson(List<Resorts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Resorts {
  Resorts({
    this.id,
    this.desinationName,
    this.placeName,
    this.image,
    this.description,
  });

  int id;
  String desinationName;
  String placeName;
  String description;
  String image;

  factory Resorts.fromJson(Map<String, dynamic> json) => Resorts(
        id: json["Id"],
        desinationName: json["DesinationName"],
        placeName: json["PlaceName"],
        description: json["Description"],
        image: json["ImageName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DesinationName": desinationName,
        "PlaceName": placeName,
        "Description": description,
        "ImageName": image,
      };
}
