import 'dart:convert';
import 'package:firstprojects/controllers/cubit/transfer_cubit/transfer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../utils/constants.dart';

class TransferCubit extends Cubit<TransferMainState> {
  TransferCubit() : super(TransferMainInitialState());

  static TransferCubit get(context) => BlocProvider.of(context);
  String url = "inventory/transfer_between_stores/";

  List<GetInvoiceIdModel> listTransferModel = [];

  Future<List<GetInvoiceIdModel>> getTransfer() async {
    emit(GetTransferLoadingState());
    try {
      var data = {'page': '1'};
      var response = await ApiBaseHelper().get(url, null, body: data);

      listTransferModel =
          (response as List).map((e) => GetInvoiceIdModel.fromJson(e)).toList();
      emit(GetTransferSuccessState());
      return listTransferModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<GetInvoiceIdModel> getTransferId(String uuid) async {
    GetInvoiceIdModel? transferModel;

    emit(GetTransferLoadingState());
    try {
      var response = await ApiBaseHelper()
          .get('inventory/transfer_between_stores/$uuid', null);

      transferModel = GetInvoiceIdModel.fromJson(response);

      emit(GetTransferSuccessState());
      return transferModel;
    } catch (error) {
      emit(GetTransferErrorState(error));
      rethrow;
    }
  }

  Future deleteTransferId(String uuid) async {
    try {
      var response = await ApiBaseHelper()
          .delete('inventory/transfer_between_stores/$uuid')
          .then((value) => Get.snackbar(
              'Portfolio Financial System'.tr, 'Delete successfully'.tr,
              backgroundColor: CupertinoColors.white,
              colorText: Constants.primaryColor));
    } catch (error) {
      rethrow;
    }
  }

  Future confirmRequest(GetInvoiceIdModel invoicesModel, String uuid) async {
    String url = 'inventory/transfer_between_stores/confirm_request/$uuid';
    try {
      var response = await ApiBaseHelper()
          .post(
              url,
              jsonEncode({
                "id": invoicesModel.id,
                "uuid": invoicesModel.uuid,
                "bond_serial": invoicesModel.bondSerial,
                "transaction_date": invoicesModel.transactionDate,
                "inventory_transaction_type_id":
                    invoicesModel.inventoryTransactionTypeId,
                "transaction_no": invoicesModel.transactionNo,
                "branch_id": invoicesModel.branchId,
                "department_id": invoicesModel.departmentId,
                "store_id": invoicesModel.storeId,
                "to_store_id": invoicesModel.toStoreId,
                "invoice_type_id": invoicesModel.invoiceTypeId,
                "salesman_id": invoicesModel.salesmanId,
                "purchase_order_number": invoicesModel.purchaseOrderNumber,
                "account_id": invoicesModel.accountId,
                "tax_type_id": invoicesModel.taxTypeId,
                "account_branch_id": invoicesModel.accountBranchId,
                "status_id": invoicesModel.statusId,
                "total_before_tax": invoicesModel.totalBeforeTax,
                "total_after_tax": invoicesModel.totalAfterTax,
                "tax": invoicesModel.tax,
                "total_checks": invoicesModel.totalChecks,
                "notes": invoicesModel.notes,
                "user_id": invoicesModel.userId,
                "account_name": invoicesModel.accountName,
                "credit_card_id": null,
                "source": invoicesModel.source,
                "latitude": null,
                "longitude": null,
                "discount": invoicesModel.discount,
                "batch_id": null,
                "visit_id": null,
                "created_at": invoicesModel.createdAt,
                "updated_at": invoicesModel.updatedAt,
                "deleted_at": null,
                "inventoryTransactionItems":
                    invoicesModel.inventoryTransactionItems
              }))
          .then((value) async {
        Get.snackbar('Portfolio Financial System'.tr,
            'Transfer confirmed successfully'.tr,
            backgroundColor: CupertinoColors.white,
            colorText: Constants.primaryColor);
      });
    } catch (e) {
      Get.snackbar('Portfolio Financial System'.tr, e.toString(),
          backgroundColor: CupertinoColors.white,
          colorText: Constants.primaryColor);
    }
  }

  Future createTransfer(GetInvoiceIdModel invoicesModel) async {
    String url = 'inventory/transfer_between_stores/initialize_request';
    var response = await ApiBaseHelper().post(url, {
      "inventory_transaction": jsonEncode(invoicesModel.toJson())
    }).then((value) async {
      Get.snackbar('Portfolio Financial System'.tr, 'Saved successfully'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.primaryColor);
    });
  }

  Future updateTransfer(GetInvoiceIdModel invoicesModel) async {
    String url = 'inventory/transfer_between_stores/';
    var response = await ApiBaseHelper()
        .put(url, {"inventory_transaction": jsonEncode(invoicesModel.toJson())},
            null)
        .then((value) async {
      Get.snackbar('Portfolio Financial System'.tr, 'Updated successfully'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.primaryColor);
    });
  }
}
