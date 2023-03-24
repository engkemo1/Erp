class BondsInitializeModel {
  List<Accounts>? accounts;
  List<Departments>? departments;
  List<Currencies>? currencies;
  Currency? currency;
  List<Branches>? branches;
  List<AccountsCharts>? accountsCharts;
  bool? autoBondNo;

  BondsInitializeModel(
      {this.accounts,
        this.departments,
        this.currencies,
        this.currency,
        this.branches,
        this.accountsCharts,
        this.autoBondNo});

  BondsInitializeModel.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(new Accounts.fromJson(v));
      });
    }
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(new Currencies.fromJson(v));
      });
    }
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    if (json['accounts_charts'] != null) {
      accountsCharts = <AccountsCharts>[];
      json['accounts_charts'].forEach((v) {
        accountsCharts!.add(new AccountsCharts.fromJson(v));
      });
    }
    autoBondNo = json['auto_bond_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    if (this.currencies != null) {
      data['currencies'] = this.currencies!.map((v) => v.toJson()).toList();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.accountsCharts != null) {
      data['accounts_charts'] =
          this.accountsCharts!.map((v) => v.toJson()).toList();
    }
    data['auto_bond_no'] = this.autoBondNo;
    return data;
  }
}

class Accounts {
  int? id;
  int? accountNo;
  String? accountNameAr;
  String? accountNameEn;
  List<AccountBranches>? accountBranches;
  String? accountName;
  Currency? currency;

  Accounts(
      {this.id,
        this.accountNo,
        this.accountNameAr,
        this.accountNameEn,
        this.accountBranches,
        this.accountName,
        this.currency});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNo = json['account_no'];
    accountNameAr = json['account_name_ar'];
    accountNameEn = json['account_name_en'];
    if (json['accountBranches'] != null) {
      accountBranches = <AccountBranches>[];
      json['accountBranches'].forEach((v) {
        accountBranches!.add(new AccountBranches.fromJson(v));
      });
    }
    accountName = json['account_name'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_no'] = this.accountNo;
    data['account_name_ar'] = this.accountNameAr;
    data['account_name_en'] = this.accountNameEn;
    if (this.accountBranches != null) {
      data['accountBranches'] =
          this.accountBranches!.map((v) => v.toJson()).toList();
    }
    data['account_name'] = this.accountName;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    return data;
  }
}

class AccountBranches {
  int? id;
  String? branchName;

  AccountBranches({this.id, this.branchName});

  AccountBranches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_name'] = this.branchName;
    return data;
  }
}

class Currency {
  int? id;
  String? nameAr;
  String? nameEn;
  var coinTransfer;
  String? shortcutName;
  String? coinExchange;
  bool? coinDefault;
  String? coinSign;
  Null? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Currency(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.coinTransfer,
        this.shortcutName,
        this.coinExchange,
        this.coinDefault,
        this.coinSign,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    coinTransfer = json['coin_transfer'];
    shortcutName = json['shortcut_name'];
    coinExchange = json['coin_exchange'];
    coinDefault = json['coin_default'];
    coinSign = json['coin_sign'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['coin_transfer'] = this.coinTransfer;
    data['shortcut_name'] = this.shortcutName;
    data['coin_exchange'] = this.coinExchange;
    data['coin_default'] = this.coinDefault;
    data['coin_sign'] = this.coinSign;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Departments {
  int? id;
  String? nameAr;
  String? nameEn;
  int? branchNo;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Departments(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.branchNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Departments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    branchNo = json['branch_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['branch_no'] = this.branchNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Currencies {
  int? id;
  String? nameAr;
  String? nameEn;
  dynamic? coinTransfer;
  String? shortcutName;
  String? coinExchange;
  bool? coinDefault;
  String? coinSign;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Currencies(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.coinTransfer,
        this.shortcutName,
        this.coinExchange,
        this.coinDefault,
        this.coinSign,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Currencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    coinTransfer = json['coin_transfer'];
    shortcutName = json['shortcut_name'];
    coinExchange = json['coin_exchange'];
    coinDefault = json['coin_default'];
    coinSign = json['coin_sign'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['coin_transfer'] = this.coinTransfer;
    data['shortcut_name'] = this.shortcutName;
    data['coin_exchange'] = this.coinExchange;
    data['coin_default'] = this.coinDefault;
    data['coin_sign'] = this.coinSign;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Branches {
  int? id;
  String? nameAr;
  String? nameEn;
  String? phone;
  String? address;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Branches(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.phone,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    phone = json['phone'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class AccountsCharts {
  int? id;
  int? accountNo;
  String? accountNameAr;
  String? accountNameEn;

  AccountsCharts(
      {this.id, this.accountNo, this.accountNameAr, this.accountNameEn});

  AccountsCharts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNo = json['account_no'];
    accountNameAr = json['account_name_ar'];
    accountNameEn = json['account_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_no'] = this.accountNo;
    data['account_name_ar'] = this.accountNameAr;
    data['account_name_en'] = this.accountNameEn;
    return data;
  }
}
