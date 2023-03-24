class AddRepVisitsModel {
  int? id;
  int? userId;
  var salesmanId;
  int? debitAccountId;
  int? accountId;
  double? latitude;
  double? longitude;

  AddRepVisitsModel(
      {this.id,
        this.userId,
        this.salesmanId,
        this.debitAccountId,
        this.accountId,
        this.latitude,
        this.longitude});

  AddRepVisitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    salesmanId = json['salesman_id'];
    debitAccountId = json['debit_account_id'];
    accountId = json['account_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['salesman_id'] = this.salesmanId;
    data['debit_account_id'] = this.debitAccountId;
    data['account_id'] = this.accountId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
