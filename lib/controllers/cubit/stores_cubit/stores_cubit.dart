import 'package:firstprojects/controllers/cubit/stores_cubit/stores_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/transactions_models/transfer_model/stores_model.dart';

class StoresCubit extends Cubit<StoresMainState> {
  StoresCubit() : super(StoresMainInitialState());

  static StoresCubit get(context) => BlocProvider.of(context);
  String url = "inventory/stores";

  List<StoresModel> listStoresModel = [];
  List<StoresModel> listStoresSearchModel = [];

  Future<List<StoresModel>> getStores() async {
    emit(GetStoresLoadingState());
    try{
    var response = await ApiBaseHelper().get(url,null
    );

    listStoresModel = (response as List)
        .map((e) => StoresModel.fromJson(e))
        .toList();
    emit(GetStoresSuccessState());
    return listStoresModel;
  }catch(error){
      emit(GetStoresErrorState(error));
      rethrow;
    }}
  addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();
    listStoresSearchModel = listStoresModel.where((search) {
      var searchTitle = search.nameAr!.toLowerCase();

      return searchTitle.contains(searchName);
    }).toList();
    emit(state);
    //print(searchList[0].displayName);
    if (searchName == "") {
      listStoresSearchModel.clear();
    } else {}
  }
}
