class StoresModel {
  var id;
  String? nameAr;
  String? nameEn;
  String? person;
  int? branchNo;
  int? accountNo;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  Branch? branch;

  StoresModel(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.person,
        this.branchNo,
        this.accountNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.branch});

  StoresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar']??'';
    nameEn = json['name_en']??'';
    person = json['person']??'';
    branchNo = json['branch_no'];
    accountNo = json['account_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    branch =
    json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
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
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? nameAr;
  var nameEn;

  Branch({this.id, this.nameAr, this.nameEn});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    nameAr = json['name_ar']??'';
    nameEn = json['name_en']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }
}
