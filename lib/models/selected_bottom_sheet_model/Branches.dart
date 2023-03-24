// To parse this JSON data, do
//
//     final branches = branchesFromJson(jsonString);

import 'dart:convert';

Branches branchesFromJson(String str) => Branches.fromJson(json.decode(str));

String branchesToJson(Branches data) => json.encode(data.toJson());

class Branches {
    Branches({
        required this.branches,
    });

    List<Branch> branches;

    factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
    };


    
}

class Branch {
    Branch({
        this.id,
        this.nameAr,
        this.nameEn,
        this.phone,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? nameAr;
    String? nameEn;
    String ?phone;
    String ?address;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        phone: json["phone"],
        address: json["address"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "phone": phone,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
