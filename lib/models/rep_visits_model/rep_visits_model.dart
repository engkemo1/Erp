
import '../invoices_model/invoices_model.dart';

class RepVisitsModel {
  int? id;
  int? salesmanId;
  int? debitAccountId;
  String? notes;
  int? status;
  var latitude;
  var longitude;
  String? closedAt;
  int? rating;
  int? cancelId;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  Account? account;
  Salesmen? salesmen;
  String? distance;
  String? address;
  String? spentTime;

  RepVisitsModel(
      {this.id,
        this.salesmanId,
        this.debitAccountId,
        this.notes,
        this.status,
        this.latitude,
        this.longitude,
        this.closedAt,
        this.rating,
        this.cancelId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.account,
        this.salesmen,
        this.distance,
        this.address,
        this.spentTime});

  RepVisitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    debitAccountId = json['debit_account_id'];
    notes = json['notes'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    closedAt = json['closed_at'];
    rating = json['rating'];
    cancelId = json['cancel_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;    distance = json['distance'];
    address = json['address'];
    spentTime = json['spent_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesman_id'] = this.salesmanId;
    data['debit_account_id'] = this.debitAccountId;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['closed_at'] = this.closedAt;
    data['rating'] = this.rating;
    data['cancel_id'] = this.cancelId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }    data['distance'] = this.distance;
    data['address'] = this.address;
    data['spent_time'] = this.spentTime;
    return data;
  }
}

class Account {
  int? id;
  String? accountNameAr;
  String? accountNameEn;
  AccountInfo? accountInfo;

  Account({this.id, this.accountNameAr, this.accountNameEn, this.accountInfo});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNameAr = json['account_name_ar'];
    accountNameEn = json['account_name_en'];
    accountInfo = json['accountInfo'] != null
        ? new AccountInfo.fromJson(json['accountInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_name_ar'] = this.accountNameAr;
    data['account_name_en'] = this.accountNameEn;
    if (this.accountInfo != null) {
      data['accountInfo'] = this.accountInfo!.toJson();
    }
    return data;
  }
}

class AccountInfo {
  String? address;
  String? latitude;
  String? longitude;

  AccountInfo({this.address, this.latitude, this.longitude});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
