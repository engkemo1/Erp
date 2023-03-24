import 'dart:convert';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/transactions_models/expenses_model/expenses_model.dart';
import '../../../view/screens/transactions/expenses_screen/expenses_screen.dart';
import 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesMainState> {
  ExpensesCubit() : super(ExpensesMainInitialState());

  static ExpensesCubit get(context) => BlocProvider.of(context);
  static const endPointUrl = "cash_van/salesman_expenses";
  List<ExpensesModel> expensesList = [];

  Future<List<ExpensesModel>> getAll() async {
    emit(GetExpensesLoadingState());
    try {
      var result = await ApiBaseHelper().get(endPointUrl, null);
      result.forEach((object) {
        expensesList.add(ExpensesModel.fromJson(object));
      });
      emit(GetExpensesSuccessState());
      return expensesList;
    } catch (ex) {
      emit(GetExpensesErrorState(ex));
      rethrow;
    }
  }

  Future delete(var id) async {
    String url = "$endPointUrl/$id";
    await ApiBaseHelper().delete(url).then((value) {
      Get.defaultDialog(
          title: value['message'],
          backgroundColor: CupertinoColors.white,
          content: const SizedBox());

      Get.back();
      Get.to(const ExpensesScreen());
    });
  }

  Future<void> update(ExpensesModel expensesModel, BuildContext context) async {
    emit(UpdateExpensesLoadingState());
    try {
      await ApiBaseHelper()
          .put(endPointUrl, expensesModel.toJson(), null)
          .then((value) {
        Get.snackbar(
            'Portfolio Financial System'.tr,
            backgroundColor: CupertinoColors.white,
            colorText: Constants.textColor2,
            'The expense has been modified successfully'.tr);

        Get.to(const ExpensesScreen());
        emit(UpdateExpensesSuccessState());
      });
    } catch (error) {
      emit(UpdateExpensesErrorState(error));
      rethrow;
    }
  }

  Future<void> create(ExpensesModel expensesModel, BuildContext context) async {
    emit(CreateExpensesLoadingState());
    try {
      await ApiBaseHelper()
          .post(endPointUrl, expensesModel.toJson())
          .then((value) {
        Get.snackbar(
            'Portfolio Financial System'.tr, 'Expense added successfully'.tr);

        Get.to(const ExpensesScreen());
      });
      emit(CreateExpensesSuccessState());
    } catch (error) {
      emit(CreateExpensesErrorState(error));
      rethrow;
    }
  }
}
