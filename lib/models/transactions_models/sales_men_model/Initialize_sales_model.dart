
import '../../selected_bottom_sheet_model/SalesTypes.dart';

class InitializeSalesModel {
  List<PayTypes>? payTypes;
  List<Stores>? stores;
  List<Cities>? cities;
  List<Areas>? areas;
  List<SalesType>? salesTypes;
  List<ItemCategories>? itemCategories;

  InitializeSalesModel(
      {this.payTypes,
        this.stores,
        this.cities,
        this.areas,
        this.salesTypes,
        this.itemCategories});

  InitializeSalesModel.fromJson(Map<String, dynamic> json) {
    if (json['payTypes'] != null) {
      payTypes = <PayTypes>[];
      json['payTypes'].forEach((v) {
        payTypes!.add(new PayTypes.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(new Areas.fromJson(v));
      });
    }
    if (json['salesTypes'] != null) {
      salesTypes = <SalesType>[];
      json['salesTypes'].forEach((v) {
        salesTypes!.add(new SalesType.fromJson(v));
      });
    }
    if (json['itemCategories'] != null) {
      itemCategories = <ItemCategories>[];
      json['itemCategories'].forEach((v) {
        itemCategories!.add(new ItemCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.payTypes != null) {
      data['payTypes'] = this.payTypes!.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    if (this.salesTypes != null) {
      data['salesTypes'] = this.salesTypes!.map((v) => v.toJson()).toList();
    }
    if (this.itemCategories != null) {
      data['itemCategories'] =
          this.itemCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayTypes {
  int? id;
  String? nameAr;
  String? nameEn;


  PayTypes(
      {this.id,
        this.nameAr,
        this.nameEn,
       });

  PayTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;

    return data;
  }
}

class Stores {
  int? id;
  String? nameAr;
  String? nameEn;
  String? person;
  int? branchNo;
  int? accountNo;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Stores(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.person,
        this.branchNo,
        this.accountNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    person = json['person'];
    branchNo = json['branch_no'];
    accountNo = json['account_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['person'] = this.person;
    data['branch_no'] = this.branchNo;
    data['account_no'] = this.accountNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Cities {
  int? id;
  String? nameAr;
  String? nameEn;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Cities(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Areas {
  int? id;
  String? nameAr;
  String? nameEn;
  int? cityId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Areas(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.cityId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class ItemCategories {
  int? id;
  String? nameAr;
  String? nameEn;
  int? parent;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  ItemCategories(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ItemCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    parent = json['parent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['parent'] = this.parent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

}
