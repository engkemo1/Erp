import 'package:firstprojects/models/user/user_id_model.dart';

class 
CustomerIdModel {
  int? id;
  String? uuid;
  String? accountNameAr;
  String? accountNameEn;
  String? accountName;
  int? accountNo;
  int? parent;
  String? recordId;
  int? parentAccountId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  AccountInfo? accountInfo;
  List<Invoices>? invoices;
  List<CashReceipts>? cashReceipts;
  List<AccountBranches>? accountBranches;
  List<String>? accountAttachments;
  List<String>? returnSalesInvoices;
  List<String>? orders;
  List<PaymentVouchers>? paymentVouchers;
  List<Checks>? checks;
  String? ordersAmount;
  int? ordersCount;
  String? invoicesAmount;
  int? invoicesCount;
  String? purchasesAmount;
  int? purchasesCount;
  String? paymentVouchersAmount;
  int? paymentVouchersCount;
  String? returnInvoicesAmount;
  int? returnInvoicesCount;
  String? cashReceiptsAmount;
  int? cashReceiptsCount;
  String? unstagedChecksAmount;
  int? unstagedChecksCount;
  String? balance;
  String? lastVisit;

  CustomerIdModel(
      {this.id,
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
        this.deletedAt,
        this.accountInfo,
        this.invoices,
        this.cashReceipts,
        this.accountBranches,
        this.accountAttachments,
        this.returnSalesInvoices,
        this.orders,
        this.paymentVouchers,
        this.checks,
        this.ordersAmount,
        this.ordersCount,
        this.invoicesAmount,
        this.invoicesCount,
        this.purchasesAmount,
        this.purchasesCount,
        this.paymentVouchersAmount,
        this.paymentVouchersCount,
        this.returnInvoicesAmount,
        this.returnInvoicesCount,
        this.cashReceiptsAmount,
        this.cashReceiptsCount,
        this.unstagedChecksAmount,
        this.unstagedChecksCount,
        this.balance,
        this.lastVisit});

  CustomerIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid= json["uuid"];

    accountNameAr = json['account_name_ar'];
    accountNameEn = json['account_name_en'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    parent = json['parent'];
        lastVisit = json['last_visit'];

    recordId = json['record_id'];
    parentAccountId = json['parent_account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    accountInfo = json['accountInfo'] != null
        ? new AccountInfo.fromJson(json['accountInfo'])
        : null;
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
    if (json['cashReceipts'] != null) {
      cashReceipts = <CashReceipts>[];
      json['cashReceipts'].forEach((v) {
        cashReceipts!.add(new CashReceipts.fromJson(v));
      });
    }
    if (json['accountBranches'] != null) {
      accountBranches = <AccountBranches>[];
      json['accountBranches'].forEach((v) {
        accountBranches!.add(new AccountBranches.fromJson(v));
      });
    }
    accountAttachments = json['accountAttachments'].cast<String>();
    returnSalesInvoices = json['returnSalesInvoices'].cast<String>();
    orders = json['orders'].cast<String>();
    if (json['paymentVouchers'] != null) {
      paymentVouchers = <PaymentVouchers>[];
      json['paymentVouchers'].forEach((v) {
        paymentVouchers!.add(new PaymentVouchers.fromJson(v));
      });
    }
    if (json['checks'] != null) {
      checks = <Checks>[];
      json['checks'].forEach((v) {
        checks!.add(new Checks.fromJson(v));
      });
    }
    ordersAmount = json['ordersAmount'];
    ordersCount = json['ordersCount'];
    invoicesAmount = json['invoicesAmount'];
    invoicesCount = json['invoicesCount'];
    purchasesAmount = json['purchasesAmount'];
    purchasesCount = json['purchasesCount'];
    paymentVouchersAmount = json['paymentVouchersAmount'];
    paymentVouchersCount = json['paymentVouchersCount'];
    returnInvoicesAmount = json['returnInvoicesAmount'];
    returnInvoicesCount = json['returnInvoicesCount'];
    cashReceiptsAmount = json['cashReceiptsAmount'];
    cashReceiptsCount = json['cashReceiptsCount'];
    unstagedChecksAmount = json['unstagedChecksAmount'];
    unstagedChecksCount = json['unstagedChecksCount'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
            data['last_visit'] = this.lastVisit;
    data ['uuid']=this.uuid;

    
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
    if (this.accountInfo != null) {
      data['accountInfo'] = this.accountInfo!.toJson();
    }
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    if (this.cashReceipts != null) {
      data['cashReceipts'] = this.cashReceipts!.map((v) => v.toJson()).toList();
    }
    if (this.accountBranches != null) {
      data['accountBranches'] =
          this.accountBranches!.map((v) => v.toJson()).toList();
    }
    data['accountAttachments'] = this.accountAttachments;
    data['returnSalesInvoices'] = this.returnSalesInvoices;
    data['orders'] = this.orders;
    if (this.paymentVouchers != null) {
      data['paymentVouchers'] =
          this.paymentVouchers!.map((v) => v.toJson()).toList();
    }
    if (this.checks != null) {
      data['checks'] = this.checks!.map((v) => v.toJson()).toList();
    }
    data['ordersAmount'] = this.ordersAmount;
    data['ordersCount'] = this.ordersCount;
    data['invoicesAmount'] = this.invoicesAmount;
    data['invoicesCount'] = this.invoicesCount;
    data['purchasesAmount'] = this.purchasesAmount;
    data['purchasesCount'] = this.purchasesCount;
    data['paymentVouchersAmount'] = this.paymentVouchersAmount;
    data['paymentVouchersCount'] = this.paymentVouchersCount;
    data['returnInvoicesAmount'] = this.returnInvoicesAmount;
    data['returnInvoicesCount'] = this.returnInvoicesCount;
    data['cashReceiptsAmount'] = this.cashReceiptsAmount;
    data['cashReceiptsCount'] = this.cashReceiptsCount;
    data['unstagedChecksAmount'] = this.unstagedChecksAmount;
    data['unstagedChecksCount'] = this.unstagedChecksCount;
    data['balance'] = this.balance;
    return data;
  }
}