// To parse this JSON data, do
//
//     final salesTypes = salesTypesFromJson(jsonString);

import 'dart:convert';

SalesTypes salesTypesFromJson(String str) => SalesTypes.fromJson(json.decode(str));

String salesTypesToJson(SalesTypes data) => json.encode(data.toJson());

class SalesTypes {
    SalesTypes({
        required this.salesTypes,
    });

    List<SalesType> salesTypes;

    factory SalesTypes.fromJson(Map<String, dynamic> json) => SalesTypes(
        salesTypes: List<SalesType>.from(json["salesTypes"].map((x) => SalesType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "salesTypes": List<dynamic>.from(salesTypes.map((x) => x.toJson())),
    };
}

class SalesType {
    SalesType({
        this.id,
        this.nameAr,
        this.nameEn,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? nameAr;
    String?nameEn;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic deletedAt;

    factory SalesType.fromJson(Map<String, dynamic> json) => SalesType(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}
