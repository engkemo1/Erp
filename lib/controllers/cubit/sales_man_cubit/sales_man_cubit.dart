import 'dart:convert';
import 'package:firstprojects/controllers/cubit/sales_man_cubit/sales_man_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/transactions_models/sales_men_model/Initialize_sales_model.dart';
import '../../../models/transactions_models/sales_men_model/sales_representative.dart';
import '../../../utils/storage.dart';

class SalesManCubit extends Cubit<SalesManMainState> {
  SalesManCubit() : super(SalesManMainInitialState());

  static SalesManCubit get(context) => BlocProvider.of(context);
  static const endPointUrl = "accounting/salesmen";
  InitializeSalesModel? initializeModel;
  List<SalesRepresentative> salesmanList = [];
  List<SalesRepresentative> salesmanSearchList = [];
  Future<InitializeSalesModel> getInitializeSales() async {
    emit(GetInitializeSalesLoadingState());
    try {
      var response = await ApiBaseHelper().get("$endPointUrl/initialize", null);
      initializeModel = InitializeSalesModel.fromJson(response);
      emit(GetInitializeSalesSuccessState());
      return initializeModel!;
    } catch (ex) {
      emit(GetInitializeSalesErrorState(ex));
      rethrow;
    }
  }

  Future<List<SalesRepresentative>> getAll() async {
    emit(GetSalesManLoadingState());
    try {
      var result = await ApiBaseHelper().get(endPointUrl, null);
      result.forEach((object) {
        salesmanList.add(SalesRepresentative.fromJson(object));
      });
      emit(GetSalesManSuccessState());
      return salesmanList;
    } catch (ex) {
      emit(GetSalesManErrorState(ex));
      rethrow;
    }
  }
  Future<SalesRepresentative> getSalesmanId() async {
    SalesRepresentative salesRepresentative =SalesRepresentative();
    try {
      var result = await ApiBaseHelper().get("$endPointUrl/${getUser()!.userCompanies!.first.salesmanId}", null);

        salesRepresentative=SalesRepresentative.fromJson(result);
        await GetStorage().write("salesman",jsonEncode(salesRepresentative.toJson()));
      return salesRepresentative;
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> update(SalesRepresentative salesManModel) async {
    emit(UpdateSalesManLoadingState());
    try {
      await ApiBaseHelper().put(
          endPointUrl, {"salesman": jsonEncode(salesManModel.toJson())}, null);
      emit(UpdateSalesManSuccessState());
    } catch (error) {
      emit(UpdateSalesManErrorState(error));
      rethrow;
    }
  }

  addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();
    salesmanSearchList = salesmanList.where((search) {
      var searchTitle = search.name!.toLowerCase();

      return searchTitle.contains(searchName);
    }).toList();
    emit(state);
    //print(searchList[0].displayName);
    if (searchName == "") {
      salesmanSearchList.clear();
    } else {}
  }
}
