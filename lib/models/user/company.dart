class Company {
  Company({
    this.id,
    this.companyName,
    this.companyAddress,
    this.companyUsername,
    this.email,
    this.phoneNumber,
    this.mobileNumber,
    this.taxNumber,
    this.tradeName,
    this.website,
    this.faxNumber,
    this.logoUrl,
    this.financialYear,
    this.endpoint,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.subscriptions,
    this.companyModules,
    this.companyCustomizations,
    this.branches,
  });

  int? id;
  String? companyName;
  String? companyAddress;
  String? companyUsername;
  String? email;
  String? phoneNumber;
  String? mobileNumber;
  String? taxNumber;
  String? tradeName;
  String? website;
  String? faxNumber;
  dynamic logoUrl;
  int? financialYear;
  dynamic endpoint;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<Subscription>? subscriptions;
  List<UserRoleElement>? companyModules;
  List<dynamic>? companyCustomizations;
  List<BranchElement>? branches;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    companyUsername: json["company_username"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    mobileNumber: json["mobile_number"],
    taxNumber: json["tax_number"],
    tradeName: json["trade_name"],
    website: json["website"],
    faxNumber: json["fax_number"],
    logoUrl: json["logo_url"],
    financialYear: json["financial_year"],
    endpoint: json["endpoint"],
    countryId: json["country_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    subscriptions: List<Subscription>.from(json["subscriptions"].map((x) => Subscription.fromJson(x))),
    companyModules: List<UserRoleElement>.from(json["company_modules"].map((x) => UserRoleElement.fromJson(x))),
    companyCustomizations: List<dynamic>.from(json["company_customizations"].map((x) => x)),
    branches: List<BranchElement>.from(json["branches"].map((x) => BranchElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "company_address": companyAddress,
    "company_username": companyUsername,
    "email": email,
    "phone_number": phoneNumber,
    "mobile_number": mobileNumber,
    "tax_number": taxNumber,
    "trade_name": tradeName,
    "website": website,
    "fax_number": faxNumber,
    "logo_url": logoUrl,
    "financial_year": financialYear,
    "endpoint": endpoint,
    "country_id": countryId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "subscriptions":subscriptions==null?[]: List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
    "company_modules": companyModules==null?[]:List<dynamic>.from(companyModules!.map((x) => x.toJson())),
    "company_customizations":companyCustomizations==null?[]: List<dynamic>.from(companyCustomizations!.map((x) => x)),
    "branches":branches==null?[] :List<dynamic>.from(branches!.map((x) => x.toJson())),
  };
}

class BranchElement {
  BranchElement({
    this.id,
    this.nameAr,
    this.nameEn,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  String? phone;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory BranchElement.fromJson(Map<String, dynamic> json) => BranchElement(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    phone: json["phone"],
    address: json["address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "phone": phone,
    "address": address,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class UserRoleElement {
  UserRoleElement({
    this.id,
  });

  int? id;

  factory UserRoleElement.fromJson(Map<String, dynamic> json) => UserRoleElement(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class Subscription {
  Subscription({
    this.date,
    this.id,
    this.periodTypeId,
    this.usersNumber,
    this.companyId,
    this.transactionNumber,
    this.subscriptionTypeId,
    this.subscriptionModelId,
    this.companiesNumber,
    this.amount,
    this.paymentDate,
    this.deletedAt,
    this.periodType,
  });

  DateTime? date;
  int? id;
  int? periodTypeId;
  int? usersNumber;
  int? companyId;
  dynamic transactionNumber;
  int? subscriptionTypeId;
  int? subscriptionModelId;
  int? companiesNumber;
  dynamic amount;
  dynamic paymentDate;
  dynamic deletedAt;
  PeriodType? periodType;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    date: DateTime.parse(json["date"]),
    id: json["id"],
    periodTypeId: json["period_type_id"],
    usersNumber: json["users_number"],
    companyId: json["company_id"],
    transactionNumber: json["transaction_number"],
    subscriptionTypeId: json["subscription_type_id"],
    subscriptionModelId: json["subscription_model_id"],
    companiesNumber: json["companies_number"],
    amount: json["amount"],
    paymentDate: json["payment_date"],
    deletedAt: json["deleted_at"],
    periodType: PeriodType.fromJson(json["period_type"]),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
    "id": id,
    "period_type_id": periodTypeId,
    "users_number": usersNumber,
    "company_id": companyId,
    "transaction_number": transactionNumber,
    "subscription_type_id": subscriptionTypeId,
    "subscription_model_id": subscriptionModelId,
    "companies_number": companiesNumber,
    "amount": amount,
    "payment_date": paymentDate,
    "deleted_at": deletedAt,
    "period_type": periodType?.toJson(),
  };
}

class PeriodType {
  PeriodType({
    this.id,
    this.name,
    this.period,
  });

  int? id;
  String? name;
  int? period;

  factory PeriodType.fromJson(Map<String, dynamic> json) => PeriodType(
    id: json["id"],
    name: json["name"],
    period: json["period"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "period": period,
  };
}