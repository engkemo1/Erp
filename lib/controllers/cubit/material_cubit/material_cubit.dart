import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/items_model/category_item_model.dart';
import '../../../models/items_model/items_model.dart';
import '../../../models/items_model/material_customer_report.dart';
import '../../../utils/storage.dart';
import 'material_state.dart';

class MaterialCubit extends Cubit<MaterialMainState> {
  MaterialCubit() : super(MaterialMainInitialState());

  static MaterialCubit get(context) => BlocProvider.of(context);

  String? getAuthorization() {
    final stroage = GetStorage();
    var x = stroage.read("token");
    return "JWT " + x ?? "null";
  }

  List<MaterialsModel> listMaterialsModel = [];
  List<CategoryItemModel> categoryItemModelList = [];
  List<CategoryItemModel> categoryItemSearchList = [];
  MaterialCustomerReportModel materialCustomerReport = MaterialCustomerReportModel();

  String userJson = GetStorage().read("user");

  Future<List<MaterialsModel>> getMaterial() async {
    emit(GetMaterialLoadingState());
    try {
      String url = "inventory/item_categories";
      ApiBaseHelper().get(url, null).then((value) {
        log(value.toString());

        listMaterialsModel =
            (value as List).map((e) => MaterialsModel.fromJson(e)).toList();
        emit(GetMaterialSuccessState());
      });
    } on Exception catch (ex) {
      emit(GetMaterialErrorState(ex));

      rethrow;
    }
    return listMaterialsModel;
  }

  Future<MaterialCustomerReportModel> getMaterialCustomerReport(int itemId,String  from,String to ) async {
    emit(GetMaterialReportsLoadingState());

    try {
      String url =
          "inventory/items/$itemId/statement/$from/$to";
      ApiBaseHelper().get(url, null).then((value) {
        log(value.toString());

        materialCustomerReport =
            MaterialCustomerReportModel.fromJson(value);
        emit(GetMaterialReportsSuccessState());});
    } on Exception catch (ex) {
      emit(GetMaterialReportsErrorState(ex));

      rethrow;
    }
    return materialCustomerReport;
  }

  Future<List<CategoryItemModel>> getCategoryItem() async {
    emit(GetMaterialLoadingState());
    try {
      String url =
          "inventory/item_categories/category_items/1537/${getUser()!.userCompanies!.first.salesmanId}";
      await ApiBaseHelper().get(url, null).then((value) {
        categoryItemModelList =
            (value as List).map((e) => CategoryItemModel.fromJson(e)).toList();
      });
      emit(GetMaterialSuccessState());
    } on Exception catch (ex) {
      emit(GetCategoryItemErrorState(ex));
      rethrow;
    }

    return categoryItemModelList;
  }

  void addSearchToList(
    var searchName,
  ) {
    searchName = searchName.toLowerCase();
    categoryItemSearchList = categoryItemModelList.where((search) {
      var searchTitle = search.nameAr!.toLowerCase();
      return searchTitle.contains(searchName);
    }).toList();
    emit(GetCategorySearchLoadingState());

    if (searchName == "") {
      categoryItemSearchList.clear();
    } else {}
  }
}
