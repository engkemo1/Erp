class CategoryItemModel {
  int? id;
  String? nameAr;
  String? nameEn;
  int? parent;
  var createdAt;
  String? updatedAt;
  var deletedAt;
  List<Items>? items;

  CategoryItemModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.parent,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.items});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    parent = json['parent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
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
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? nameAr;
  String? nameEn;
  String? imageUrl;
  ItemUnit? itemUnit;
  String? itemNumber;
  TaxValue? taxValue;
  int? conversionFactor;
  int? currentQuantity;
  int? discountAmount;
  int? discountPercentage;
  int? discount;
  int? itemId;
  int? quantity = 0;
  bool? isPercentage;

  var currentPriceBeforeTax;
  var currentPriceAfterTax;
  var taxAmount;

  Items(
      {this.nameAr,
      this.itemId,
        this.isPercentage,
      this.nameEn,
      this.imageUrl,
      this.itemUnit,
      this.itemNumber,
      this.taxValue,
      this.conversionFactor,
      this.currentQuantity,
      this.currentPriceBeforeTax,
      this.currentPriceAfterTax,
      this.taxAmount});

  Items.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    itemId = json["item_id"];
    imageUrl = json['image_url'];
    itemUnit = json['itemUnit'] != null
        ? new ItemUnit.fromJson(json['itemUnit'])
        : null;
    itemNumber = json['item_number'];
    taxValue = json['tax_value'] != null
        ? new TaxValue.fromJson(json['tax_value'])
        : null;
    conversionFactor = json['conversion_factor'];
    discount = json['discount'];

    currentQuantity = json['currentQuantity'];
   currentPriceBeforeTax = json['current_price_before_tax'];
    currentPriceAfterTax = json['current_price_after_tax'];
    taxAmount = json['tax_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_ar'] = this.nameAr;
    data['discount'] = this.discount;
    data["item_id"] = this.itemId;
    data['name_en'] = this.nameEn;
    data['image_url'] = this.imageUrl;
    if (this.itemUnit != null) {
      data['itemUnit'] = this.itemUnit!.toJson();
    }
    data['item_number'] = this.itemNumber;
    if (this.taxValue != null) {
      data['tax_value'] = this.taxValue!.toJson();
    }
    data['conversion_factor'] = this.conversionFactor;
    data['currentQuantity'] = this.currentQuantity;
     data['current_price_before_tax'] = this.currentPriceBeforeTax;
    data['current_price_after_tax'] = this.currentPriceAfterTax;
    data['tax_amount'] = this.taxAmount;
    return data;
  }
}

class ItemUnit {
  int? id;
  String? nameAr;
  String? nameEn;
  Null? createdAt;
  String? updatedAt;
  Null? deletedAt;

  ItemUnit(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ItemUnit.fromJson(Map<String, dynamic> json) {
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

class TaxValue {
  int? id;
  String? nameAr;
  String? nameEn;
  int? value;
  Null? createdAt;
  String? updatedAt;
  Null? deletedAt;

  TaxValue(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  TaxValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
