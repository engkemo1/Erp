import 'package:firstprojects/models/invoices_model/get_invoice_id_model/salesmen_model.dart';
import '../../selected_bottom_sheet_model/Branches.dart';
import 'item_info_model.dart';
import 'item_model.dart';
import 'item_unit_model.dart';

class GetInvoiceIdModel {
  int? id;
  String? uuid;
  int? bondSerial;
  var currentPriceBeforeTax;
  var currentPriceAfterTax;
  String? transactionDate;
  int? inventoryTransactionTypeId;
  int? transactionNo;
  int? branchId;
  int? departmentId;
  int? storeId;
  int? invoiceTypeId;
  int? taxAmount;
  int? salesmanId;
  String? purchaseOrderNumber;
  int? accountId;
  int? taxTypeId;
  int? accountBranchId;
  int? paymentTypeId;
  var totalBeforeTax;
  var totalAfterTax;
  var tax;
  int? totalChecks;
  String? notes;
  int? userId;
  int? statusId;
  String? accountName;
  var creditCardId;
  String? source;
  var latitude;
  var longitude;
  int? discount;
  var batchId;
  var visitId;
  String? createdAt;
  String? updatedAt;
  int? toStoreId;
  int? fromStoreId;
  FromStore? fromStore;
  FromStore? toStore;

  var deletedAt;
  Branch? branch;
  Branch? payType;
  List<InventoryTransactionItems>? inventoryTransactionItems;
  Salesmen? salesmen;

  GetInvoiceIdModel(
      {this.id,
      this.uuid,
      this.toStoreId,
      this.statusId,
      this.fromStoreId,
      this.bondSerial,
      this.transactionDate,
      this.inventoryTransactionTypeId,
      this.transactionNo,
      this.paymentTypeId,
      this.fromStore,
      this.toStore,
      this.branchId,
      this.departmentId,
      this.storeId,
      this.invoiceTypeId,
      this.salesmanId,
      this.purchaseOrderNumber,
      this.accountId,
      this.taxTypeId,
      this.accountBranchId,
      this.totalBeforeTax,
      this.totalAfterTax,
      this.tax,
      this.totalChecks,
      this.notes,
      this.userId,
      this.accountName,
      this.creditCardId,
      this.source,
      this.latitude,
      this.longitude,
      this.discount,
      this.batchId,
      this.visitId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.branch,
      this.payType,
      this.inventoryTransactionItems,
      this.salesmen});

  GetInvoiceIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    uuid = json['uuid'];
    statusId = json['status_id'];
    taxAmount = json['tax_amount'];

    paymentTypeId = json['payment_type_id'];
    toStoreId = json['to_store_id'];
    fromStore = json['from_store'] != null
        ? new FromStore.fromJson(json['from_store'])
        : null;
    toStore = json['to_store'] != null
        ? new FromStore.fromJson(json['to_store'])
        : null;
    bondSerial = json['bond_serial'];
    transactionDate = json['transaction_date'];
    inventoryTransactionTypeId = json['inventory_transaction_type_id'];
    transactionNo = json['transaction_no'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    storeId = json['store_id'];
    fromStoreId = json['from_store_id'];

    invoiceTypeId = json['invoice_type_id'];
    salesmanId = json['salesman_id'];
    purchaseOrderNumber = json['purchase_order_number'];
    accountId = json['account_id'];
    taxTypeId = json['tax_type_id'];
    accountBranchId = json['account_branch_id'];
    totalBeforeTax = json['total_before_tax'];
    totalAfterTax = json['total_after_tax'];
    tax = json['tax'];
    totalChecks = json['total_checks'];
    notes = json['notes'];
    userId = json['user_id'];
    accountName = json['account_name'];
    creditCardId = json['credit_card_id'];
    source = json['source'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    discount = json['discount'];
    batchId = json['batch_id'];
    visitId = json['visit_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
    payType =
        json['payType'] != null ? new Branch.fromJson(json['payType']) : null;
    if (json['inventoryTransactionItems'] != null) {
      inventoryTransactionItems = <InventoryTransactionItems>[];
      json['inventoryTransactionItems'].forEach((v) {
        inventoryTransactionItems!
            .add(new InventoryTransactionItems.fromJson(v));
      });
    }
    salesmen = json['salesmen'] != null
        ? new Salesmen.fromJson(json['salesmen'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['payment_type_id'] = this.paymentTypeId;
    data['to_store_id'] = this.toStoreId;
    data['from_store_id'] = this.fromStoreId;
    data['tax_amount'] = this.taxAmount;

    if (this.fromStore != null) {
      data['from_store'] = this.fromStore!.toJson();
    }
    if (this.toStore != null) {
      data['to_store'] = this.toStore!.toJson();
    }
    data['bond_serial'] = this.bondSerial;
    data['transaction_date'] = this.transactionDate;
    data['inventory_transaction_type_id'] = this.inventoryTransactionTypeId;
    data['transaction_no'] = this.transactionNo;
    data['branch_id'] = this.branchId;
    data['department_id'] = this.departmentId;
    data['store_id'] = this.storeId;
    data['invoice_type_id'] = this.invoiceTypeId;
    data['salesman_id'] = this.salesmanId;
    data['purchase_order_number'] = this.purchaseOrderNumber;
    data['account_id'] = this.accountId;
    data['tax_type_id'] = this.taxTypeId;
    data['account_branch_id'] = this.accountBranchId;
    data['total_before_tax'] = this.totalBeforeTax;
    data['total_after_tax'] = this.totalAfterTax;
    data['tax'] = this.tax;
    data['total_checks'] = this.totalChecks;
    data['notes'] = this.notes;
    data['user_id'] = this.userId;
    data['account_name'] = this.accountName;
    data['credit_card_id'] = this.creditCardId;
    data['source'] = this.source;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['discount'] = this.discount;
    data['batch_id'] = this.batchId;
    data['visit_id'] = this.visitId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.payType != null) {
      data['payType'] = this.payType!.toJson();
    }
    if (this.inventoryTransactionItems != null) {
      data['inventoryTransactionItems'] =
          this.inventoryTransactionItems!.map((v) => v.toJson()).toList();
    }
    if (this.salesmen != null) {
      data['salesmen'] = this.salesmen!.toJson();
    }
    return data;
  }
}

class InventoryTransactionItems {
  int? id;
  int? inventoryTransactionId;
  int? itemId;
  int? itemUnitId;
  int? itemInfoId;
  String? itemName;
  String? rate;
  int? quantity;
  var price;
  int? discountAmount;
  int? discountPercentage;
  var taxAmount;
  int? taxPercentage;
  var totalBeforeTax;
  var totalAfterTax;
  int? lastCost;
  int? avgCost;
  int? lowerCost;
  int? biggestCost;
  Null? batchNumber;
  Null? expiryDate;
  var customerSalesPrice;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Item? item;
  ItemsInfo? itemsInfo;
  ItemUnit? itemUnit;
  String? itemNumber;
  String? nameAr;
  String? nameEn;
  bool? isPercentage;
  int? minQuantity;
  String? imageUrl;
  int? weight;
  int? highestDiscountRate;
  String? itemUnitName;

  InventoryTransactionItems(
      {this.id,
      this.inventoryTransactionId,
      this.itemId,
      this.itemUnitId,
      this.itemInfoId,
      this.isPercentage,
      this.itemName,
      this.rate,
      this.quantity,
      this.price,
      this.discountAmount,
      this.discountPercentage,
      this.taxAmount,
      this.taxPercentage,
      this.totalBeforeTax,
      this.totalAfterTax,
      this.lastCost,
      this.avgCost,
      this.lowerCost,
      this.biggestCost,
      this.batchNumber,
      this.expiryDate,
      this.customerSalesPrice,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.item,
      this.itemsInfo,
      this.itemUnit,
      this.itemNumber,
      this.nameAr,
      this.nameEn,
      this.minQuantity,
      this.imageUrl,
      this.weight,
      this.highestDiscountRate,
      this.itemUnitName});

  InventoryTransactionItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inventoryTransactionId = json['inventory_transaction_id'];
    itemId = json['item_id'];
    itemUnitId = json['item_unit_id'];
    itemInfoId = json['item_info_id'];
    itemName = json['item_name'];
    rate = json['rate'];
    quantity = json['quantity'];
    price = json['price'];
    discountAmount = json['discount_amount'];
    discountPercentage = json['discount_percentage'];
    taxAmount = json['tax_amount'];
    taxPercentage = json['tax_percentage'];
    totalBeforeTax = json['total_before_tax'];
    totalAfterTax = json['total_after_tax'];
    lastCost = json['last_cost'];
    avgCost = json['avg_cost'];
    lowerCost = json['lower_cost'];
    biggestCost = json['biggest_cost'];
    batchNumber = json['batch_number'];
    expiryDate = json['expiry_date'];
    customerSalesPrice = json['customer_sales_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    itemsInfo = json['itemsInfo'] != null
        ? new ItemsInfo.fromJson(json['itemsInfo'])
        : null;
    itemUnit = json['itemUnit'] != null
        ? new ItemUnit.fromJson(json['itemUnit'])
        : null;
    itemNumber = json['item_number'];
    nameAr = json['name_ar'];

    nameEn = json['name_en'];
    minQuantity = json['min_quantity'];
    imageUrl = json['image_url'];
    weight = json['weight'];
    highestDiscountRate = json['highest_discount_rate'];
    itemUnitName = json['item_unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inventory_transaction_id'] = this.inventoryTransactionId;
    data['item_id'] = this.itemId;
    data['item_unit_id'] = this.itemUnitId;
    data['item_info_id'] = this.itemInfoId;
    data['item_name'] = this.itemName;
    data['rate'] = this.rate;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount_amount'] = this.discountAmount;
    data['discount_percentage'] = this.discountPercentage;
    data['tax_amount'] = this.taxAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['total_before_tax'] = this.totalBeforeTax;
    data['total_after_tax'] = this.totalAfterTax;
    data['last_cost'] = this.lastCost;
    data['avg_cost'] = this.avgCost;
    data['lower_cost'] = this.lowerCost;
    data['biggest_cost'] = this.biggestCost;
    data['batch_number'] = this.batchNumber;
    data['expiry_date'] = this.expiryDate;
    data['customer_sales_price'] = this.customerSalesPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.itemsInfo != null) {
      data['itemsInfo'] = this.itemsInfo!.toJson();
    }
    if (this.itemUnit != null) {
      data['itemUnit'] = this.itemUnit!.toJson();
    }
    data['item_number'] = this.itemNumber;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['min_quantity'] = this.minQuantity;
    data['image_url'] = this.imageUrl;
    data['weight'] = this.weight;
    data['highest_discount_rate'] = this.highestDiscountRate;
    data['item_unit_name'] = this.itemUnitName;
    return data;
  }
}

class FromStore {
  int? id;
  String? nameAr;
  String? nameEn;
  String? person;
  int? branchNo;
  int? accountNo;
  bool? notifyManager;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  FromStore(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.person,
      this.branchNo,
      this.accountNo,
      this.notifyManager,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  FromStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    person = json['person'];
    branchNo = json['branch_no'];
    accountNo = json['account_no'];
    notifyManager = json['notify_manager'];
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
    data['notify_manager'] = this.notifyManager;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}


