import 'dart:convert';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/cash receipt model/cash_receipt_model.dart';
import '../customer_cubit/customer_cubit.dart';
import 'cash_receipt_state.dart';

class CashReceiptCubit extends Cubit<CashReceiptMainState> {
  CashReceiptCubit() : super(CashReceiptMainInitialState());

  static CashReceiptCubit get(context) => BlocProvider.of(context);
  CashReceiptModel createCashReceiptModel = CashReceiptModel();
  List<CashReceiptModel> cashReceiptModelList = [];
  CashReceiptModel cashReceiptModel = CashReceiptModel();

  Future<CashReceiptModel> addCashReceipt(
    int id,
    CashReceiptModel cashReceiptModel,
  ) async {
    emit(CreateCashReceiptLoadingState());
    try {
      String url = "accounting/cashReceipts?accountId=$id";
      var response = await ApiBaseHelper().post(url, {
        "cash_receipt": jsonEncode(cashReceiptModel.toJson())
      }).then((value) async {
        createCashReceiptModel = CashReceiptModel.fromJson(value);
        Get.snackbar(
          'Portfolio Financial System'.tr,
          'Voucher saved successfully'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.textColor2,
        );
        emit(CreateCashReceiptSuccessState());
        return createCashReceiptModel;
      });
    } on Exception catch (error) {
      emit(CreateCashReceiptErrorState(error));
      rethrow;
    }
    return createCashReceiptModel;
  }

  updateCashReceipt(int id, CashReceiptModel cashReceiptModel) async {
    String url = "accounting/cashReceipts?accountId=$id";
    emit(CreateCashReceiptLoadingState());
    try {
      var response = await ApiBaseHelper()
          .put(url, {"cash_receipt": jsonEncode(cashReceiptModel.toJson())},
              null)
          .then((value) async {
        emit(UpdateCashReceiptSuccessState());
        Get.snackbar(
          'Portfolio Financial System'.tr,
          'Receipt voucher modified successfully'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.textColor2,
        );
      });
    } on Exception catch (error) {
      emit(UpdateCashReceiptErrorState(error));
      rethrow;
    }
  }

  Future<List<CashReceiptModel>> getCashReceipt(String id) async {
    String url = "accounting/cashReceipts";
    emit(GetCashReceiptLoadingState());

    try {
      var response =
          await ApiBaseHelper().get(url, null, body: {'accountId': id});
      cashReceiptModelList =
          (response as List).map((e) => CashReceiptModel.fromJson(e)).toList();
      emit(GetCashReceiptSuccessState());
    } catch (error) {
      rethrow;
    }
    return cashReceiptModelList;
  }

  Future<CashReceiptModel> getCashReceiptById(
    var id,
  ) async {
    String url = "accounting/cashReceipts/$id";
    emit(GetCashReceiptByIdLoadingState());
    try {
      var response = await ApiBaseHelper().get(url, null);
      cashReceiptModel = CashReceiptModel.fromJson(response);
      emit(GetCashReceiptByIdSuccessState());

      return cashReceiptModel;
    } catch (error) {
      emit(GetCashReceiptByIdErrorState(error));
      rethrow;
    }
  }

  Future deleteCashReceipt(var id, var rId, BuildContext context) async {
    String url = "accounting/cashReceipts/$id";
    await ApiBaseHelper().delete(url).then((value) {

      Get.defaultDialog(
          title: value['message'],
          backgroundColor: CupertinoColors.white,
          content: SizedBox());
    });
    emit(DeleteCashReceiptLoadingState());
    return cashReceiptModelList;
  }
}
