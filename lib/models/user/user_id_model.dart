


import '../account_statment_model/bonds_initialize_model.dart';
import '../selected_bottom_sheet_model/SalesTypes.dart';

class AccountInfo {
  int? id;
  int? accountId;
  int? accountNo;
  int? coinNo;
  int? branchNo;
  int? placeNo;
  int? salesmanNo;
  int? paymethodNo;
  int? maxDebit;
  int? period;
  String? address;
  String? mobileNo;
  String? phoneNo;
  String? email;
  String? faxNo;
  String? contactPerson;
  String? taxNo;
  bool? stop;
  int? discountPercentage;
  String? website;
  String? state;
  int? salesTypeId;
  int? taxesIncluded;
  String? latitude;
  String? longitude;
  String? number;
  PayType? payType;
  Salesmen? salesmen;
  SalesType? salesType;
Currency? currency;
  Branch? branch;
  Branch? area;

  AccountInfo(
      {this.id,
        this.accountId,
        this.accountNo,
        this.coinNo,
        this.branchNo,
        this.placeNo,
        this.salesmanNo,
        this.paymethodNo,
        this.maxDebit,
        this.period,
        this.address,
        this.mobileNo,
        this.phoneNo,
        this.email,
        this.faxNo,
        this.contactPerson,
        this.taxNo,
        this.stop,
        this.discountPercentage,
        this.website,
        this.state,
        this.payType,
        this.salesTypeId,
        this.taxesIncluded,
        this.latitude,
        this.longitude,
        this.number,
        this.salesType,
        this.salesmen,
        this.currency,
        this.branch,
        this.area});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    accountNo = json['account_no'];
    coinNo = json['coin_no'];
    branchNo = json['branch_no'];
    placeNo = json['place_no'];
    salesmanNo = json['salesman_no'];
    paymethodNo = json['paymethod_no'];
    maxDebit = json['max_debit'];
    period = json['period'];
    address = json['address'];
    mobileNo = json['mobile_no'];
    phoneNo = json['phone_no'];
    email = json['email'];
    faxNo = json['fax_no'];
    contactPerson = json['contact_person'];
    taxNo = json['tax_no'];
    stop = json['stop'];
    discountPercentage = json['discount_percentage'];
    website = json['website'];
    state = json['state'];
    salesTypeId = json['sales_type_id'];
    taxesIncluded = json['taxes_included'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    number = json['number'];
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;
    salesType =
    json['salesType'] != null ? new SalesType.fromJson(json['salesType']) : null;
    payType =
    json['payType'] != null ? new PayType.fromJson(json['payType']) : null;
    branch =
    json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    currency =
    json['currency'] != null ? new Currency.fromJson(json['currency']) : null;
    area = json['area'] != null ? new Branch.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['account_id'] = this.accountId;
    data['account_no'] = this.accountNo;
    data['coin_no'] = this.coinNo;
    data['branch_no'] = this.branchNo;
    data['place_no'] = this.placeNo;
    data['salesman_no'] = this.salesmanNo;
    data['paymethod_no'] = this.paymethodNo;
    data['max_debit'] = this.maxDebit;
    data['period'] = this.period;
    data['address'] = this.address;
    data['mobile_no'] = this.mobileNo;
    data['phone_no'] = this.phoneNo;
    data['email'] = this.email;
    data['fax_no'] = this.faxNo;
    data['contact_person'] = this.contactPerson;
    data['tax_no'] = this.taxNo;
    data['stop'] = this.stop;
    data['discount_percentage'] = this.discountPercentage;
    data['website'] = this.website;
    data['state'] = this.state;
    data['sales_type_id'] = this.salesTypeId;
    data['taxes_included'] = this.taxesIncluded;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['number'] = this.number;
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    return data;
  }
}

class Salesmen {
  String? name;

  Salesmen({this.name});

  Salesmen.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Branch {
  String? nameAr;
  String? nameEn;

  Branch({this.nameAr, this.nameEn});

  Branch.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Invoices {
  int? id;
  int? bondSerial;
  int? transactionNo;
  String? transactionDate;
  int? invoiceTypeId;
  dynamic totalBeforeTax;
  dynamic totalAfterTax;
  PayType? payType;
  Salesmen? salesmen;

  Invoices(
      {this.id,
        this.bondSerial,
        this.transactionNo,
        this.transactionDate,
        this.invoiceTypeId,
        this.totalBeforeTax,
        this.totalAfterTax,
        this.payType,
        this.salesmen});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bondSerial = json['bond_serial'];
    transactionNo = json['transaction_no'];
    transactionDate = json['transaction_date'];
    invoiceTypeId = json['invoice_type_id'];
    totalBeforeTax = json['total_before_tax'];
    totalAfterTax = json['total_after_tax'];
    payType =
    json['payType'] != null ? new PayType.fromJson(json['payType']) : null;
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bond_serial'] = this.bondSerial;
    data['transaction_no'] = this.transactionNo;
    data['transaction_date'] = this.transactionDate;
    data['invoice_type_id'] = this.invoiceTypeId;
    data['total_before_tax'] = this.totalBeforeTax;
    data['total_after_tax'] = this.totalAfterTax;
    if (this.payType != null) {
      data['payType'] = this.payType!.toJson();
    }
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }
    return data;
  }
}

class PayType {
  int? id;
  String? nameAr;
  String? nameEn;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PayType(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  PayType.fromJson(Map<String, dynamic> json) {
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


class CashReceipts {
  int? id;
  int? bondNo;
  int? bondType;
  int? serial;
  String? bondDate;
  int? cash;
  int? cheque;
  String? statement;
  Salesmen? salesmen;
  List<CashReceiptsDetails>? cashReceiptsDetails;

  CashReceipts(
      {this.id,
        this.bondNo,
        this.bondType,
        this.serial,
        this.bondDate,
        this.cash,
        this.cheque,
        this.statement,
        this.salesmen,
        this.cashReceiptsDetails});

  CashReceipts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bondNo = json['bond_no'];
    bondType = json['bond_type'];
    serial = json['serial'];
    bondDate = json['bond_date'];
    cash = json['cash'];
    cheque = json['cheque'];
    statement = json['statement'];
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;
    if (json['cashReceiptsDetails'] != null) {
      cashReceiptsDetails = <CashReceiptsDetails>[];
      json['cashReceiptsDetails'].forEach((v) {
        cashReceiptsDetails!.add(new CashReceiptsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bond_no'] = this.bondNo;
    data['bond_type'] = this.bondType;
    data['serial'] = this.serial;
    data['bond_date'] = this.bondDate;
    data['cash'] = this.cash;
    data['cheque'] = this.cheque;
    data['statement'] = this.statement;
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }
    if (this.cashReceiptsDetails != null) {
      data['cashReceiptsDetails'] =
          this.cashReceiptsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CashReceiptsDetails {
  int? id;
  int? cashReceiptId;
  int? departmentId;
  int? accountBranchId;
  String? statement;
  int? amount;
  int? accountId;
  String? documentUrl;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CashReceiptsDetails(
      {this.id,
        this.cashReceiptId,
        this.departmentId,
        this.accountBranchId,
        this.statement,
        this.amount,
        this.accountId,
        this.documentUrl,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  CashReceiptsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cashReceiptId = json['cash_receipt_id'];
    departmentId = json['department_id'];
    accountBranchId = json['account_branch_id'];
    statement = json['statement'];
    amount = json['amount'];
    accountId = json['account_id'];
    documentUrl = json['document_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cash_receipt_id'] = this.cashReceiptId;
    data['department_id'] = this.departmentId;
    data['account_branch_id'] = this.accountBranchId;
    data['statement'] = this.statement;
    data['amount'] = this.amount;
    data['account_id'] = this.accountId;
    data['document_url'] = this.documentUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class AccountBranches {
  int? id;
  int? accountId;
  String? branchName;
  String? branchNumber;
  String? contactName;
  String? contactPhoneNumber;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  AccountBranches(
      {this.id,
        this.accountId,
        this.branchName,
        this.branchNumber,
        this.contactName,
        this.contactPhoneNumber,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  AccountBranches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    branchName = json['branch_name'];
    branchNumber = json['branch_number'];
    contactName = json['contact_name'];
    contactPhoneNumber = json['contact_phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['branch_name'] = this.branchName;
    data['branch_number'] = this.branchNumber;
    data['contact_name'] = this.contactName;
    data['contact_phone_number'] = this.contactPhoneNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class PaymentVouchers {
  int? id;
  int? bondNo;
  int? bondType;
  int? serial;
  String? bondDate;
  int? cash;
  int? cheque;
  String? statement;
  Salesmen? salesmen;

  PaymentVouchers(
      {this.id,
        this.bondNo,
        this.bondType,
        this.serial,
        this.bondDate,
        this.cash,
        this.cheque,
        this.statement,
        this.salesmen});

  PaymentVouchers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bondNo = json['bond_no'];
    bondType = json['bond_type'];
    serial = json['serial'];
    bondDate = json['bond_date'];
    cash = json['cash'];
    cheque = json['cheque'];
    statement = json['statement'];
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bond_no'] = this.bondNo;
    data['bond_type'] = this.bondType;
    data['serial'] = this.serial;
    data['bond_date'] = this.bondDate;
    data['cash'] = this.cash;
    data['cheque'] = this.cheque;
    data['statement'] = this.statement;
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }
    return data;
  }
}

class Checks {
  int? id;
  String? chequeNo;
  String? bankName;
  String? chequeDate;
  int? chequeAmount;
  String? chequePerson;
  int? agentAccountNo;
  int? accountId;
  int? actionId;
  int? bankId;
  int? statusId;
  bool? dated;
  int? typeId;
  String? documentUrl;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  PayType? chequeStatus;

  Checks(
      {this.id,
        this.chequeNo,
        this.bankName,
        this.chequeDate,
        this.chequeAmount,
        this.chequePerson,
        this.agentAccountNo,
        this.accountId,
        this.actionId,
        this.bankId,
        this.statusId,
        this.dated,
        this.typeId,
        this.documentUrl,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.chequeStatus});

  Checks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chequeNo = json['cheque_no'];
    bankName = json['bank_name'];
    chequeDate = json['cheque_date'];
    chequeAmount = json['cheque_amount'];
    chequePerson = json['cheque_person'];
    agentAccountNo = json['agent_account_no'];
    accountId = json['account_id'];
    actionId = json['action_id'];
    bankId = json['bank_id'];
    statusId = json['status_id'];
    dated = json['dated'];
    typeId = json['type_id'];
    documentUrl = json['document_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    chequeStatus = json['chequeStatus'] != null
        ? new PayType.fromJson(json['chequeStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cheque_no'] = this.chequeNo;
    data['bank_name'] = this.bankName;
    data['cheque_date'] = this.chequeDate;
    data['cheque_amount'] = this.chequeAmount;
    data['cheque_person'] = this.chequePerson;
    data['agent_account_no'] = this.agentAccountNo;
    data['account_id'] = this.accountId;
    data['action_id'] = this.actionId;
    data['bank_id'] = this.bankId;
    data['status_id'] = this.statusId;
    data['dated'] = this.dated;
    data['type_id'] = this.typeId;
    data['document_url'] = this.documentUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.chequeStatus != null) {
      data['chequeStatus'] = this.chequeStatus!.toJson();
    }
    return data;
  }
}
