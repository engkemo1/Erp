// To parse this JSON data, do
//
//     final salesmen = salesmenFromJson(jsonString);

import 'dart:convert';

Salesmen salesmenFromJson(String str) => Salesmen.fromJson(json.decode(str));

String salesmenToJson(Salesmen data) => json.encode(data.toJson());

class Salesmen {
  Salesmen({
    required this.salesmen,
  });

  List<Salesman> salesmen;

  factory Salesmen.fromJson(Map<String, dynamic> json) => Salesmen(
    salesmen: List<Salesman>.from(json["salesmen"].map((x) => Salesman.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "salesmen": List<dynamic>.from(salesmen.map((x) => x.toJson())),
  };
}

class Salesman {
  Salesman({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Salesman.fromJson(Map<String, dynamic> json) => Salesman(
    id: json["id"] !=null ? int.parse(json["id"].toString()): 0,
    name: json["name"] !=null ? json["name"] : "" ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
