// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
    City({
        required this.cities,
    });

    List<CityElement> cities;

    factory City.fromJson(Map<String, dynamic> json) => City(
        cities: List<CityElement>.from(json["cities"].map((x) => CityElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
    };
}

class CityElement {
    CityElement({
        this.id,
        this.nameAr,
        this.nameEn,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? nameAr;
    String? nameEn;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory CityElement.fromJson(Map<String, dynamic> json) => CityElement(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
