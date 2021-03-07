import 'dart:convert';

List<Resorts> resortsFromJson(String str) => List<Resorts>.from(json.decode(str).map((x) => Resorts.fromJson(x)));

String resortsToJson(List<Resorts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Resorts {
  Resorts({
    this.id,
    this.desinationName,
    this.placeName,
  });

  int id;
  String desinationName;
  String placeName;

  factory Resorts.fromJson(Map<String, dynamic> json) => Resorts(
    id: json["Id"],
    desinationName: json["DesinationName"],
    placeName: json["PlaceName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "DesinationName": desinationName,
    "PlaceName": placeName,
  };
}
