class Salesmen {
  int? id;
  String? name;
  int? storeId;
  int? paymentTypeId;
  int? salesTypeId;
  var customersDiscount;

  Salesmen(
      {this.id,
        this.name,
        this.storeId,
        this.paymentTypeId,
        this.salesTypeId,
        this.customersDiscount});

  Salesmen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['store_id'];
    paymentTypeId = json['payment_type_id'];
    salesTypeId = json['sales_type_id'];
    customersDiscount = json['customers_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['payment_type_id'] = this.paymentTypeId;
    data['sales_type_id'] = this.salesTypeId;
    data['customers_discount'] = this.customersDiscount;
    return data;
  }
}
