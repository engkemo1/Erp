import 'package:firstprojects/models/invoices_model/get_invoice_id_model/get_invoice_id.dart';

class PrepareGoodModel {
  int? id;
  String? uuid;
  int? bondSerial;
  String? transactionDate;
  String? accountName;
  Branch? branch;
  Branch? payType;
  int? statusId;
  Salesmen? salesmen;
  List<InventoryTransactionItems>? inventoryTransactionItems;

  PrepareGoodModel(
      {this.id,
      this.uuid,
      this.bondSerial,
      this.transactionDate,
      this.accountName,
      this.statusId,
      this.branch,
      this.payType,
      this.salesmen,
      this.inventoryTransactionItems});

  PrepareGoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    bondSerial = json['bond_serial'];
    transactionDate = json['transaction_date'];
    accountName = json['account_name'];
    statusId = json['status_id'];

    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    payType =
        json['payType'] != null ? new Branch.fromJson(json['payType']) : null;
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;
    if (json['inventoryTransactionItems'] != null) {
      inventoryTransactionItems = <InventoryTransactionItems>[];
      json['inventoryTransactionItems'].forEach((v) {
        inventoryTransactionItems!.add(InventoryTransactionItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['bond_serial'] = this.bondSerial;
    data['transaction_date'] = this.transactionDate;
    data['account_name'] = this.accountName;
    data['status_id'] = this.statusId;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.payType != null) {
      data['payType'] = this.payType!.toJson();
    }
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }
    if (this.inventoryTransactionItems != null) {
      data['inventoryTransactionItems'] =
          this.inventoryTransactionItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? nameAr;

  Branch({this.id, this.nameAr});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    return data;
  }
}

class Salesmen {
  int? id;
  String? name;
  int? storeId;
  int? paymentTypeId;
  int? salesTypeId;
  int? customersDiscount;

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
