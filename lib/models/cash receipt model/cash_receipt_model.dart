import 'package:firstprojects/models/customers/create_customer_model.dart';

class CashReceiptModel {
  int? bondNo;
  int? bondType;
  String? bondDate;
  int? branchNo;
  int? bondId;
  int? departmentNo;
  int? salesmanNo;
  int? cash;
  int? cheque;
  int? visitId;
  int? debitAccountId;
  int? creditAccountId;
  String? statement;
  int? exchange;
  Salesmann? salesman;
  int? foreignPrice;
  int? latitude;
  int? longitude;
  String? source;
  List<Cheques>? cheques;
  int? userId;
  int? serial;
  int? id;
  String? uuid;
  int ?accountBranchId;
  DebitAccount? debitAccount;

  CashReceiptModel(
      {
        this.uuid,this.bondNo,
        this.bondType,
        this.visitId,
        this.accountBranchId,
        this.debitAccount,
        this.bondDate,
        this.branchNo,
        this.bondId,
        this.departmentNo,
        this.salesmanNo,
        this.cash,
        this.cheque,
        this.debitAccountId,
        this.creditAccountId,
        this.statement,
        this.exchange,
        this.foreignPrice,
        this.latitude,
        this.longitude,
        this.source,
        this.cheques,
        this.userId,
        this.serial,
        this.id,});

  CashReceiptModel.fromJson(Map<String, dynamic> json) {
    bondNo = json['bond_no'];
    uuid = json['uuid'];
    visitId = json['visit_id'];
    accountBranchId=json['account_branch_id'];
    bondType = json['bond_type'];
    bondDate = json['bond_date'];
    branchNo = json['branch_no'];
    bondId = json['bond_id'];
    departmentNo = json['department_no'];
    salesmanNo = json['salesman_no'];
    cash = json['cash'];
    cheque = json['cheque'];
    debitAccountId = json['debit_account_id'];
    creditAccountId = json['credit_account_id'];
    statement = json['statement'];
    exchange = json['exchange'];
    foreignPrice = json['foreign_price'];
    latitude = json['latitude'];
    salesman= json['salesmen'] != null
        ?  Salesmann.fromJson(json['salesmen'])
        : null;
    debitAccount = json['debitAccount'] != null
        ? new DebitAccount.fromJson(json['debitAccount'])
        : null;
    longitude = json['longitude'];
    source = json['source'];
    if (json['cheques'] != null) {
      cheques = <Cheques>[];
      json['cheques'].forEach((v) {
        cheques!.add(new Cheques.fromJson(v));
      });
    }
    userId = json['user_id'];
    serial = json['serial'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bond_no'] = this.bondNo;
    data['visit_id'] = this.visitId;
data['account_branch_id']=accountBranchId;
    data['uuid'] = this.uuid;
    if (this.debitAccount != null) {
      data['debitAccount'] = this.debitAccount!.toJson();
    }
    data['bond_type'] = this.bondType;
    data['bond_date'] = this.bondDate;
    data['branch_no'] = this.branchNo;
    data['bond_id'] = this.bondId;
    data['department_no'] = this.departmentNo;
    data['salesman_no'] = this.salesmanNo;
    data['cash'] = this.cash;
    data['cheque'] = this.cheque;
    data['debit_account_id'] = this.debitAccountId;
    data['credit_account_id'] = this.creditAccountId;
    data['statement'] = this.statement;
    data['exchange'] = this.exchange;
    data['foreign_price'] = this.foreignPrice;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['source'] = this.source;
    if (this.cheques != null) {
      data['cheques'] = this.cheques!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this.userId;
    data['serial'] = this.serial;
    data['id'] = this.id;
    return data;
  }
}

class Cheques {
  String? chequeNo;
  String? bankName;
  String? chequeDate;
  int? chequeAmount;
  String? chequePerson;
  int? agentAccountNo;
  int? bankAccountNo;
  int? serial;
  int? actionId;
  int? accountId;
  int? statusId;
  int? typeId;

  Cheques(
      {this.chequeNo,
        this.bankName,
        this.chequeDate,
        this.chequeAmount,
        this.chequePerson,
        this.agentAccountNo,
        this.bankAccountNo,
        this.serial,
        this.actionId,
        this.accountId,
        this.statusId,
        this.typeId});

  Cheques.fromJson(Map<String, dynamic> json) {
    chequeNo = json['cheque_no'];
    bankName = json['bank_name'];
    chequeDate = json['cheque_date'];
    chequeAmount = json['cheque_amount'];
    chequePerson = json['cheque_person'];
    agentAccountNo = json['agent_account_no'];
    bankAccountNo = json['bank_account_no'];
    serial = json['serial'];
    actionId = json['action_id'];
    accountId = json['account_id'];
    statusId = json['status_id'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cheque_no'] = this.chequeNo;
    data['bank_name'] = this.bankName;
    data['cheque_date'] = this.chequeDate;
    data['cheque_amount'] = this.chequeAmount;
    data['cheque_person'] = this.chequePerson;
    data['agent_account_no'] = this.agentAccountNo;
    data['bank_account_no'] = this.bankAccountNo;
    data['serial'] = this.serial;
    data['action_id'] = this.actionId;
    data['account_id'] = this.accountId;
    data['status_id'] = this.statusId;
    data['type_id'] = this.typeId;
    return data;
  }
}
class DebitAccount {
  int? id;
  String? uuid;
  String? accountNameAr;
  String? accountNameEn;
  String? accountName;
  int? accountNo;
  int? parent;
  Null? recordId;
  int? parentAccountId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  DebitAccount({this.id,
    this.uuid,
    this.accountNameAr,
    this.accountNameEn,
    this.accountName,
    this.accountNo,
    this.parent,
    this.recordId,
    this.parentAccountId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt});

  DebitAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    accountNameAr = json['account_name_ar'];
    accountNameEn = json['account_name_en'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    parent = json['parent'];
    recordId = json['record_id'];
    parentAccountId = json['parent_account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['account_name_ar'] = this.accountNameAr;
    data['account_name_en'] = this.accountNameEn;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    data['parent'] = this.parent;
    data['record_id'] = this.recordId;
    data['parent_account_id'] = this.parentAccountId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}