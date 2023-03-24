import 'dart:convert';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../models/invoices_model/invoices_model.dart';
import '../../../utils/constants.dart';
import 'Inventory_state.dart';

class InventoryCubit extends Cubit<InventoryMainState> {
  InventoryCubit() : super(InventoryMainInitialState());

  static InventoryCubit get(context) => BlocProvider.of(context);

  String? getAuthorization() {
    final stroage = GetStorage();
    var x = stroage.read("token");
    return "JWT " + x ?? "null";
  }

  final String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<InvoicesModel> invoicesModeList = [];
  GetInvoiceIdModel invoicesModel = GetInvoiceIdModel();

  Future updateInventory(
      int screenId, GetInvoiceIdModel invoicesModel, String notes) async {
    String url = screenId == 1
        ? "inventory/invoices"
        : screenId == 2
            ? "inventory/purchases_orders"
            : 'inventory/return_invoices';
    var response = await ApiBaseHelper()
        .put(
            url,
            {
              "inventory_transaction": jsonEncode({
                "id": invoicesModel.id,
                "uuid": invoicesModel.uuid,
                "bond_serial": invoicesModel.bondSerial,
                "transaction_no": invoicesModel.transactionNo,
                "account_name": invoicesModel.accountName,
                "transaction_date": invoicesModel.transactionDate,
                "purchase_order_number": invoicesModel.purchaseOrderNumber,
                "invoice_type_id": invoicesModel.invoiceTypeId,
                "branch_id": invoicesModel.branchId,
                "department_id": invoicesModel.departmentId,
                "account_id": invoicesModel.accountId,
                "account_branch_id": invoicesModel.accountBranchId,
                "salesman_id": invoicesModel.salesmanId,
                "store_id": invoicesModel.storeId,
                "to_store_id": 0,
                "tax_type_id": invoicesModel.taxTypeId,
                "notify_manager": 1,
                "total_before_tax": invoicesModel.totalBeforeTax,
                "tax": invoicesModel.tax,
                "discount": invoicesModel.discount,
                "total_after_tax": invoicesModel.totalAfterTax,
                "total_checks": invoicesModel.totalChecks,
                "inventoryTransactionItems":
                    invoicesModel.inventoryTransactionItems!
                        .map((e) => {
                              "name_ar": e.nameAr,
                              "name_en": e.nameEn,
                              "item_name": e.itemName,
                              "rate": e.rate,
                              "customer_sales_price": e.customerSalesPrice,
                              "weight": e.weight,
                              "last_cost": e.lastCost,
                              "avg_cost": e.avgCost,
                              "lower_cost": e.lowerCost,
                              "biggest_cost": e.biggestCost,
                              "item_id": e.itemId,
                              "item_info_id": e.itemInfoId,
                              "quantity": e.quantity,
                              "item_unit_id": e.itemUnitId,
                              "item_number": e.itemNumber,
                              "price": e.price,
                              "item_unit_name": e.itemUnitName,
                              "tax_percentage": e.taxPercentage,
                              "total_before_tax": e.totalBeforeTax,
                              "total_after_tax": e.totalAfterTax,
                              "discount_amount": e.discountAmount,
                              "discount_percentage": e.discountPercentage,
                              "tax_amount": e.taxAmount,
                            })
                        .toList(),
                "checks": [],
                "source": invoicesModel.source,
                "permission_type_id": 1,
                "notes": notes
              })
            },
            null)
        .then((value) async {
      Get.snackbar(
        'Portfolio Financial System'.tr,
        'Updated successfully'.tr,
        backgroundColor: CupertinoColors.white,
        colorText: Constants.textColor2,
      );
    });
  }

  Future<GetInvoiceIdModel> createInventory(int screenId, GetInvoiceIdModel invoicesModel) async {
    String url = screenId == 1
        ? "inventory/invoices"
        : screenId == 2
            ? "inventory/purchases_orders"
            : 'inventory/return_invoices';
    var response = await ApiBaseHelper().post(url, {
      "inventory_transaction": jsonEncode(invoicesModel.toJson())
    }).then((value) async {
      invoicesModel=GetInvoiceIdModel.fromJson(value);

          Get.snackbar(
        'Portfolio Financial System'.tr,
        'Saved successfully'.tr,
        backgroundColor: CupertinoColors.white,
        colorText: Constants.textColor2,
      );
    });
    return invoicesModel;
  }

  Future<List<InvoicesModel>> getInventory(int screenId, String uuid) async {
    String url = screenId == 1
        ? "inventory/invoices"
        : screenId == 2
            ? "inventory/purchases_orders"
            : 'inventory/return_invoices';

    emit(GetInventoryLoadingState());
    try {
      var response =
          await ApiBaseHelper().get(url, null, body: {'accountId': uuid});
      invoicesModeList =
          (response as List).map((e) => InvoicesModel.fromJson(e)).toList();

      emit(GetInventorySuccessState());
      return invoicesModeList;
    } catch (error) {
      emit(GetInventoryErrorState(error));
      rethrow;
    }
  }

  Future<GetInvoiceIdModel> getInventoryById(var id, int screenId) async {
    String url = screenId == 1
        ? "inventory/invoices/$id"
        : screenId == 2
            ? "inventory/purchases_orders/$id"
            : 'inventory/return_invoices/$id';
    emit(GetInventoryIdLoadingState());
    try {
      var response = await ApiBaseHelper().get(url, {
        "Authorization": getAuthorization()!,
        'Content-Type': 'application/json'
      });
      invoicesModel = GetInvoiceIdModel.fromJson(response);

      emit(GetInventoryIdSuccessState());
      return invoicesModel;
    } catch (error) {
      emit(GetInventoryIdErrorState(error));
      rethrow;
    }
  }

  Future deleteInventory(
    var id,
    int screenId,
  ) async {
    String url = screenId == 1
        ? "inventory/invoices/$id"
        : screenId == 2
            ? "inventory/purchases_orders/$id"
            : 'inventory/return_invoices/$id';
    await ApiBaseHelper().delete(url).then((value) {
      Get.defaultDialog(
          title: value['message'],
          backgroundColor: CupertinoColors.white,
          content: SizedBox());
      Get.back();
    });
  }
}
