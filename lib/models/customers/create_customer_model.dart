import 'dart:convert';

import 'package:firstprojects/models/selected_bottom_sheet_model/SalesTypes.dart';



class CreateCustomerModel {
  CreateCustomerModel({
    this.id,
    this.uuid,

    this.accountNameAr,
    this.accountNameEn,
    this.accountName,
    this.accountNo,
    this.parent,
    this.recordId,
    this.parentAccountId,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.mobileNo,
    this.phoneNo,
    this.area,
    this.salesman,
    this.salesType,
    this.salesTypeId,
    this.salesmanId,
    this.contactPerson,
    this.email,
    this.paymethodNo,
    this.coinNo,
    this.placeNo,
    this.branchNo,
  });

  int? id;
  String? uuid;
  String? accountNameAr;
  String? accountNameEn;
  String? accountName;
  int? accountNo;
  int? parent;
  dynamic recordId;
  int? parentAccountId;
  DateTime? createdAt;
  var updatedAt;
  String? address;
  String? mobileNo;
  String? phoneNo;
  Areaa? area;
  Salesmann? salesman;
  int? salesmanId;
  SalesType? salesType;
  int? salesTypeId;
  String? contactPerson;
  String? email;
  int? paymethodNo;
  int? coinNo;
  int? placeNo;
  int? branchNo;

  factory CreateCustomerModel.fromJson(Map<String, dynamic> json) =>
      CreateCustomerModel(
        id: json["id"],
        uuid: json["uuid"],

        accountNameAr:
        json["account_name_ar"] != null ? json["account_name_ar"] : "",
        accountNameEn:
        json["account_name_en"] != null ? json["account_name_en"] : "",
        accountName: json["account_name"] != null ? json["account_name"] : "",
        accountNo: json["account_no"] != null
            ? int.parse(json["account_no"].toString())
            : 0,
        recordId: json["record_id"] != null
            ? int.parse(json["record_id"].toString())
            : 0,


        address: json["address"] != null ? json["address"] : "",
        mobileNo: json["mobile_no"] != null ? json["mobile_no"] : "",
        phoneNo: json["phone_no"],
        area: Areaa.fromJson(json["area"]),


      );

  Map<String, dynamic> toJson() => {
    "id":id,
    'uuid':uuid,

    'account_name_ar': accountNameAr.toString(),
    'account_name_en': accountNameEn.toString(),
    'sales_type_id': salesTypeId,
    'salesman_no': salesmanId,
    'account_name': accountNameAr.toString(),
    'address': address.toString(),
    'mobile_no': mobileNo.toString(),
    'phone_no': phoneNo.toString(),
    'place_no': placeNo ,
    'contact_person': contactPerson.toString(),
    'email': email.toString(),
    'paymethod_no': paymethodNo ,
    'coin_no': coinNo ,
    'branch_no': branchNo ,
    "accountInfo": {
      'sales_type_id': salesTypeId ,
      'salesman_no': salesmanId ,
      'account_name': accountNameAr.toString(),
      'address': address.toString(),
      'mobile_no': mobileNo.toString(),
      'phone_no': phoneNo.toString(),
      'place_no': placeNo  ,
      'contact_person': contactPerson.toString(),
      'email': email.toString(),
      'paymethod_no': paymethodNo,
      'coin_no': coinNo,
      'branch_no': branchNo,
    }
  };
}

Salesmenn salesmenFromJson(String str) => Salesmenn.fromJson(json.decode(str));

String salesmenToJson(Salesmenn data) => json.encode(data.toJson());

class Salesmenn {
  Salesmenn({
    required this.salesmen,
  });

  List<Salesmann> salesmen;

  factory Salesmenn.fromJson(Map<String, dynamic> json) => Salesmenn(
    salesmen: List<Salesmann>.from(
        json["salesmen"].map((x) => Salesmann.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "salesmen": List<dynamic>.from(salesmen.map((x) => x.toJson())),
  };
}

class Salesmann {
  Salesmann({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Salesmann.fromJson(Map<String, dynamic> json) => Salesmann(
    id: json["id"] != null ? int.parse(json["id"].toString()) : 0,
    name: json["name"] != null ? json["name"] : "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Areaa {
  Areaa({
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

  factory Areaa.fromJson(Map<String, dynamic> json) => Areaa(
    id: json["id"] != null ? int.parse(json["id"].toString()) : 0,
    nameAr: json["name_ar"] != null ? json["name_ar"] : "",
    nameEn: json["name_en"] != null ? json["name_en"] : "",
    cityId: json["city_id"] != null ? int.parse(json["city_id"]) : 0,
    //  createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    //  deletedAt: json["deleted_at"],
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