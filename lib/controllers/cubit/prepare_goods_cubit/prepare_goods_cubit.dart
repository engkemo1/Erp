import 'dart:convert';
import 'package:firstprojects/controllers/cubit/prepare_goods_cubit/prepare_goods_state.dart';
import 'package:firstprojects/models/prepare_good_model/prepare_good_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../utils/constants.dart';

class PrepareGoodsCubit extends Cubit<PrepareGoodsMainState> {
  PrepareGoodsCubit() : super(PrepareGoodsMainInitialState());
  static PrepareGoodsCubit get(context) => BlocProvider.of(context);
  List<PrepareGoodModel> listPrepareGoodModel = [];

  Future<List<PrepareGoodModel>> getPrepareGoods() async {
    emit(GetPrepareGoodsLoadingState());
    var data = {'page': '1'};
    try {
      String url = "inventory/prepare_orders/";
      ApiBaseHelper().get(url, null, body: data).then((value) {
        listPrepareGoodModel =
            (value as List).map((e) => PrepareGoodModel.fromJson(e)).toList();
        emit(GetPrepareGoodsSuccessState());
      });
    } on Exception catch (ex) {
      emit(GetPrepareGoodsErrorState(ex));

      rethrow;
    }
    return listPrepareGoodModel;
  }

  Future<GetInvoiceIdModel> getPrepareGoodsById(String uuid) async {
    GetInvoiceIdModel? prepareGoodModel;

    emit(GetPrepareGoodsLoadingState());
    try {
      var response =
          await ApiBaseHelper().get('inventory/prepare_orders/$uuid', null);

      prepareGoodModel = GetInvoiceIdModel.fromJson(response);

      emit(GetPrepareGoodsLoadingState());
      return prepareGoodModel;
    } catch (error) {
      emit(GetPrepareGoodsLoadingState());
      rethrow;
    }
  }

  // Future<List<PrepareGoodModel>> getPrepareGoodsById(String uuid) async {
  //     GetInvoiceIdModel? transferModel;
  //   emit(GetPrepareGoodsLoadingState());
  //   var data = {'page': '1'};
  //   try {
  //     String url = "inventory/prepare_orders/$uuid";
  //     ApiBaseHelper().get(url, null, body: data).then((value) {
  //       log(value.toString());

  //       listPrepareGoodModel =
  //           (value as List).map((e) => PrepareGoodModel.fromJson(e)).toList();
  //       emit(GetPrepareGoodsSuccessState());
  //     });
  //   } on Exception catch (ex) {
  //     emit(GetPrepareGoodsErrorState(ex));

  //     rethrow;
  //   }
  //   return listPrepareGoodModel;
  // }

  Future createPrepareGood(GetInvoiceIdModel prepareGoodModel) async {
    String url = 'inventory/prepare_orders/';
    var response = await ApiBaseHelper().post(url, {
      "inventory_transaction": jsonEncode(prepareGoodModel.toJson())
    }).then((value) async {
      Get.snackbar('Portfolio Financial System'.tr, 'Saved successfully'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.primaryColor);
    });
  }

  Future updatePrepareGood(GetInvoiceIdModel prepareGoodModel) async {
    String url = 'inventory/prepare_orders/';
    var response = await ApiBaseHelper()
        .put(
            url,
            {"inventory_transaction": jsonEncode(prepareGoodModel.toJson())},
            null)
        .then((value) async {
      Get.snackbar('Portfolio Financial System'.tr, 'Updated successfully'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.primaryColor);
    });
  }
}
