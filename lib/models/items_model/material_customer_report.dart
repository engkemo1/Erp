class MaterialCustomerReportModel {
  List<Analysis>? analysis;
  List<Statements>? statements;
  Null? unitTypes;
  int? numberOfTransactions;
  int? quantityUnitType1;
  int? quantityUnitType2;
  int? quantityUnitType3;

  MaterialCustomerReportModel(
      {this.analysis,
        this.statements,
        this.unitTypes,
        this.numberOfTransactions,
        this.quantityUnitType1,
        this.quantityUnitType2,
        this.quantityUnitType3});

  MaterialCustomerReportModel.fromJson(Map<String, dynamic> json) {
    if (json['analysis'] != null) {
      analysis = <Analysis>[];
      json['analysis'].forEach((v) {
        analysis!.add(new Analysis.fromJson(v));
      });
    }
    if (json['statements'] != null) {
      statements = <Statements>[];
      json['statements'].forEach((v) {
        statements!.add(new Statements.fromJson(v));
      });
    }
    unitTypes = json['unit_types'];
    numberOfTransactions = json['number_of_transactions'];
    quantityUnitType1 = json['quantityUnitType1'];
    quantityUnitType2 = json['quantityUnitType2'];
    quantityUnitType3 = json['quantityUnitType3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.analysis != null) {
      data['analysis'] = this.analysis!.map((v) => v.toJson()).toList();
    }
    if (this.statements != null) {
      data['statements'] = this.statements!.map((v) => v.toJson()).toList();
    }
    data['unit_types'] = this.unitTypes;
    data['number_of_transactions'] = this.numberOfTransactions;
    data['quantityUnitType1'] = this.quantityUnitType1;
    data['quantityUnitType2'] = this.quantityUnitType2;
    data['quantityUnitType3'] = this.quantityUnitType3;
    return data;
  }
}

class Analysis {
  String? label;
  int? value1;
  int? value2;

  Analysis({this.label, this.value1, this.value2});

  Analysis.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value1 = json['value1'];
    value2 = json['value2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value1'] = this.value1;
    data['value2'] = this.value2;
    return data;
  }
}

class Statements {
  String? uuid;
  String? statement;
  String? unitName;
  String? transactionDate;
  int? transactionNo;
  int? bondSerial;
  int? unitType;
  String? accountName;
  String? salesmanName;
  String? createdAt;
  int? quantity;
  String? price;
  String? cost;
  int? quantityUnitType1;
  int? quantityUnitType2;
  int? quantityUnitType3;
  int? inventoryTransactionTypeId;

  Statements(
      {this.uuid,
        this.statement,
        this.unitName,
        this.transactionDate,
        this.transactionNo,
        this.bondSerial,
        this.unitType,
        this.accountName,
        this.salesmanName,
        this.createdAt,
        this.quantity,
        this.price,
        this.cost,
        this.quantityUnitType1,
        this.quantityUnitType2,
        this.quantityUnitType3,
        this.inventoryTransactionTypeId});

  Statements.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    statement = json['statement'];
    unitName = json['unit_name'];
    transactionDate = json['transaction_date'];
    transactionNo = json['transaction_no'];
    bondSerial = json['bond_serial'];
    unitType = json['unit_type'];
    accountName = json['account_name'];
    salesmanName = json['salesman_name'];
    createdAt = json['created_at'];
    quantity = json['quantity'];
    price = json['price'];
    cost = json['cost'];
    quantityUnitType1 = json['quantity_unit_type_1'];
    quantityUnitType2 = json['quantity_unit_type_2'];
    quantityUnitType3 = json['quantity_unit_type_3'];
    inventoryTransactionTypeId = json['inventory_transaction_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['statement'] = this.statement;
    data['unit_name'] = this.unitName;
    data['transaction_date'] = this.transactionDate;
    data['transaction_no'] = this.transactionNo;
    data['bond_serial'] = this.bondSerial;
    data['unit_type'] = this.unitType;
    data['account_name'] = this.accountName;
    data['salesman_name'] = this.salesmanName;
    data['created_at'] = this.createdAt;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['cost'] = this.cost;
    data['quantity_unit_type_1'] = this.quantityUnitType1;
    data['quantity_unit_type_2'] = this.quantityUnitType2;
    data['quantity_unit_type_3'] = this.quantityUnitType3;
    data['inventory_transaction_type_id'] = this.inventoryTransactionTypeId;
    return data;
  }
}