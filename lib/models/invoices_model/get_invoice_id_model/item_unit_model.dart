class ItemUnit {
  int? id;
  String? nameAr;
  String? nameEn;
  String? updatedAt;

  ItemUnit(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.updatedAt,
       });

  ItemUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
