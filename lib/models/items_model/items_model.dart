class MaterialsModel {
  int? id;
  String? nameAr;
  String? nameEn;
  int? parent;
  var createdAt;
  String? updatedAt;
  var deletedAt;
  ItemCategory? itemCategory;

  MaterialsModel(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.itemCategory});

  MaterialsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'] ?? '';
    nameEn = json['name_en'] ?? '';
    parent = json['parent'] ?? 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'] ?? '';
    deletedAt = json['deleted_at'];
    itemCategory = json['itemCategory'] != null
        ? new ItemCategory.fromJson(json['itemCategory'])
        : null;
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
    if (this.itemCategory != null) {
      data['itemCategory'] = this.itemCategory!.toJson();
    }
    return data;
  }
}

class ItemCategory {
  int? id;
  String? nameAr;
  String? nameEn;
  int? parent;
  var createdAt;
  String? updatedAt;
  var deletedAt;

  ItemCategory(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.parent,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ItemCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'] ?? '';
    nameEn = json['name_en'] ?? '';
    parent = json['parent'] ?? 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'] ?? '';
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
