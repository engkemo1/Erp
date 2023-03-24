import '../../selected_bottom_sheet_model/PayType.dart';
import '../../selected_bottom_sheet_model/SalesTypes.dart';

class SalesRepresentative {
  int? id;
  String? name;
  String? address;
  String? phone;
  int? storeId;
  int? salesPonus;
  int? collectPonus;
  bool? isSalesman;
  bool? isWorker;
  String? vehicleId;
  String? vehicleType;
  bool? isCollector;
  bool? isDriver;
  bool? isOrderSalesman;
  int? paymentTypeId;
  int? salesTypeId;
  int? customersDiscount;
  bool? canEditPrice;
  int? maximumQuantitiesCost;
  int? searchTransactionsPeriod;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  SalesType? salesTypes;
  PayType? payTypes;

  Store? store;

  SalesRepresentative(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.storeId,
      this.salesPonus,
      this.collectPonus,
      this.isSalesman,
      this.isWorker,
      this.vehicleId,
      this.vehicleType,
      this.isCollector,
      this.isDriver,
      this.isOrderSalesman,
      this.paymentTypeId,
      this.salesTypeId,
      this.customersDiscount,
      this.canEditPrice,
      this.maximumQuantitiesCost,
      this.searchTransactionsPeriod,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.store});

  SalesRepresentative.fromJson(Map<String, dynamic> json) {
    payTypes =
        json['payType'] != null ? new PayType.fromJson(json['payType']) : null;

    salesTypes = json['salesType'] != null
        ? new SalesType.fromJson(json['salesType'])
        : null;
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    storeId = json['store_id'];
    salesPonus = json['sales_ponus'];
    collectPonus = json['collect_ponus'];
    isSalesman = json['is_salesman'];
    isWorker = json['is_worker'];
    vehicleId = json['vehicle_id'];
    vehicleType = json['vehicle_type'];
    isCollector = json['is_collector'];
    isDriver = json['is_driver'];
    isOrderSalesman = json['is_order_salesman'];
    paymentTypeId = json['payment_type_id'];
    salesTypeId = json['sales_type_id'];
    customersDiscount = json['customers_discount'];
    canEditPrice = json['can_edit_price'];
    maximumQuantitiesCost = json['maximum_quantities_cost'];
    searchTransactionsPeriod = json['search_transactions_period'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['store_id'] = this.storeId;
    data['sales_ponus'] = this.salesPonus;
    data['collect_ponus'] = this.collectPonus;
    data['is_salesman'] = this.isSalesman;
    data['is_worker'] = this.isWorker;
    data['vehicle_id'] = this.vehicleId;
    data['vehicle_type'] = this.vehicleType;
    data['is_collector'] = this.isCollector;
    data['is_driver'] = this.isDriver;
    data['is_order_salesman'] = this.isOrderSalesman;
    data['payment_type_id'] = this.paymentTypeId;
    data['sales_type_id'] = this.salesTypeId;
    data['customers_discount'] = this.customersDiscount;
    data['can_edit_price'] = this.canEditPrice;
    data['maximum_quantities_cost'] = this.maximumQuantitiesCost;
    data['search_transactions_period'] = this.searchTransactionsPeriod;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  String? nameAr;
  String? nameEn;
  String? person;
  int? branchNo;
  int? accountNo;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Store(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.person,
      this.branchNo,
      this.accountNo,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    person = json['person'];
    branchNo = json['branch_no'];
    accountNo = json['account_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['person'] = this.person;
    data['branch_no'] = this.branchNo;
    data['account_no'] = this.accountNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
