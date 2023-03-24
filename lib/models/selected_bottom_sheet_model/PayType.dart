// To parse this JSON data, do
//
//     final payTypes = payTypesFromJson(jsonString);

import 'dart:convert';

PayTypes payTypesFromJson(String str) => PayTypes.fromJson(json.decode(str));

String payTypesToJson(PayTypes data) => json.encode(data.toJson());

class PayTypes {
    PayTypes({
        required this.payTypes,
    });

    List<PayType> payTypes;

    factory PayTypes.fromJson(Map<String, dynamic> json) => PayTypes(
        payTypes: List<PayType>.from(json["payTypes"].map((x) => PayType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "payTypes": List<dynamic>.from(payTypes.map((x) => x.toJson())),
    };
}

class PayType {
    PayType({
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
    dynamic createdAt;
    dynamic updatedAt;
    dynamic deletedAt;

    factory PayType.fromJson(Map<String, dynamic> json) => PayType(
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
