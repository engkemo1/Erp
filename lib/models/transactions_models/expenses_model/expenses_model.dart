class ExpensesModel {
  int? id;
  int? salesmanId;
  String? documentUrl;
  String? expensesName;
  var amount;
  int? batchId;
  String? date;
  String? notes;
  String? source;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ExpensesModel(
      {this.id,
      this.salesmanId,
      this.documentUrl,
      this.expensesName,
      this.amount,
      this.batchId,
      this.date,
      this.notes,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesmanId = json['salesman_id'];
    documentUrl = json['document_url'];
    expensesName = json['expenses_name'];
    amount = json['amount'];
    batchId = json['batch_id'];
    date = json['date'];
    notes = json['notes'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id.toString();
    data['salesman_id'] = this.salesmanId.toString();
    data['document_url'] = this.documentUrl;
    data['expenses_name'] = this.expensesName;
    data['amount'] = this.amount.toString();
    data['batch_id'] = this.batchId.toString();
    data['date'] = this.date;
    data['notes'] = this.notes;
    data['source'] = this.source;

    return data;
  }
}
