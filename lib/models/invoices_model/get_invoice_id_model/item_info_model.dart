class ItemsInfo {
  int? id;
  String? nameAr;
  String? nameEn;
  int? categoryNo;
  int? typeNo;
  int? classNo;
  int? taxNo;
  int? originNo;
  int? minQuantity;
  int? maxDiscount;
  int? account1;
  int? account2;
  String? imageUrl;
  int? rate;
  int? customerFees;
  int? procurementFees;
  int? categorySerial;
  int? itemType;
  bool? itemFreeze;
  var customerSalesPrice;
  int? weight;
  int? lastCost;
  int? avgCost;
  int? lowerCost;
  int? biggestCost;
  int? unitTypes;
  int? highestDiscountRate;
  int? maximumQuantityLimit;
  int? minimumQuantityLimit;
  int? demandLimit;
  Null? createdAt;
  String? updatedAt;
  Null? deletedAt;

  ItemsInfo(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.categoryNo,
        this.typeNo,
        this.classNo,
        this.taxNo,
        this.originNo,
        this.minQuantity,
        this.maxDiscount,
        this.account1,
        this.account2,
        this.imageUrl,
        this.rate,
        this.customerFees,
        this.procurementFees,
        this.categorySerial,
        this.itemType,
        this.itemFreeze,
        this.customerSalesPrice,
        this.weight,
        this.lastCost,
        this.avgCost,
        this.lowerCost,
        this.biggestCost,
        this.unitTypes,
        this.highestDiscountRate,
        this.maximumQuantityLimit,
        this.minimumQuantityLimit,
        this.demandLimit,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ItemsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    categoryNo = json['category_no'];
    typeNo = json['type_no'];
    classNo = json['class_no'];
    taxNo = json['tax_no'];
    originNo = json['origin_no'];
    minQuantity = json['min_quantity'];
    maxDiscount = json['max_discount'];
    account1 = json['account1'];
    account2 = json['account2'];
    imageUrl = json['image_url'];
    rate = json['rate'];
    customerFees = json['customer_fees'];
    procurementFees = json['procurement_fees'];
    categorySerial = json['category_serial'];
    itemType = json['item_type'];
    itemFreeze = json['item_freeze'];
    customerSalesPrice = json['customer_sales_price'];
    weight = json['weight'];
    lastCost = json['last_cost'];
    avgCost = json['avg_cost'];
    lowerCost = json['lower_cost'];
    biggestCost = json['biggest_cost'];
    unitTypes = json['unit_types'];
    highestDiscountRate = json['highest_discount_rate'];
    maximumQuantityLimit = json['maximum_quantity_limit'];
    minimumQuantityLimit = json['minimum_quantity_limit'];
    demandLimit = json['demand_limit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['category_no'] = this.categoryNo;
    data['type_no'] = this.typeNo;
    data['class_no'] = this.classNo;
    data['tax_no'] = this.taxNo;
    data['origin_no'] = this.originNo;
    data['min_quantity'] = this.minQuantity;
    data['max_discount'] = this.maxDiscount;
    data['account1'] = this.account1;
    data['account2'] = this.account2;
    data['image_url'] = this.imageUrl;
    data['rate'] = this.rate;
    data['customer_fees'] = this.customerFees;
    data['procurement_fees'] = this.procurementFees;
    data['category_serial'] = this.categorySerial;
    data['item_type'] = this.itemType;
    data['item_freeze'] = this.itemFreeze;
    data['customer_sales_price'] = this.customerSalesPrice;
    data['weight'] = this.weight;
    data['last_cost'] = this.lastCost;
    data['avg_cost'] = this.avgCost;
    data['lower_cost'] = this.lowerCost;
    data['biggest_cost'] = this.biggestCost;
    data['unit_types'] = this.unitTypes;
    data['highest_discount_rate'] = this.highestDiscountRate;
    data['maximum_quantity_limit'] = this.maximumQuantityLimit;
    data['minimum_quantity_limit'] = this.minimumQuantityLimit;
    data['demand_limit'] = this.demandLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
