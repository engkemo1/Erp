// To parse this JSON data, do
//
//     final areas = areasFromJson(jsonString);

import 'dart:convert';

Areas areasFromJson(String str) => Areas.fromJson(json.decode(str));

String areasToJson(Areas data) => json.encode(data.toJson());

class Areas {
    Areas({
        required this.areas,
    });

    List<Area> areas;

    factory Areas.fromJson(Map<String, dynamic> json) => Areas(
        areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "areas": List<dynamic>.from(areas.map((x) => x.toJson())),
    };
}

class Area {
    Area({
        this.id,
        this.nameAr,
        this.nameEn,
        this.cityId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? nameAr;
    String? nameEn;
    int? cityId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        cityId: json["city_id"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "city_id": cityId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
