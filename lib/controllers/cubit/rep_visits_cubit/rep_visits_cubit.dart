import 'dart:convert';
import 'package:firstprojects/controllers/cubit/rep_visits_cubit/rep_visits_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/rep_visits.dart';
import '../../../models/rep_visits_model/SalesVisitReasonsCancellationModel.dart';
import '../../../models/rep_visits_model/rep_visits_model.dart';
import '../../../utils/storage.dart';
import '../../../view/bottom_navigation_screen.dart';
import '../auth_cubit/auth_cubit.dart';

class RepVisitsCubit extends Cubit<RepVisitsMainState> {
  RepVisitsCubit() : super(RepVisitsMainInitialState());

  static RepVisitsCubit get(context) => BlocProvider.of(context);

  String? getAuthorization() {
    final stroage = GetStorage();
    var x = stroage.read("token");
    return "JWT " + x ?? "null";
  }

  List<RepVisitsModel> repVisitsModelList = [];
  List<SalesVisitReasonsCancellationModel> visitReasonsCancellationList = [];

  Future addVisit(AddRepVisitsModel repVisitsModel) async {
    try {
      var r = ApiBaseHelper().post(
          'cash_van/rep_visits', jsonEncode(repVisitsModel.toJson()), header: {
        "Authorization": getAuthorization()!,
        'Content-Type': 'application/json'
      }).then((value) {
        GetStorage().write("visitId", value['id']);
      });
      emit(AddVisitSuccessState());
    } catch (error) {
      rethrow;
    }
  }

  Future getRepVisitSalesMan(String id) async {
    emit(GetRepVisitLoadingState());
    try {
      var data = {'salesmanId': id};
      ApiBaseHelper()
          .get('cash_van/rep_visits', null, body: data)
          .then((value) {
        repVisitsModelList =
            (value as List).map((e) => RepVisitsModel.fromJson(e)).toList();
        emit(GetRepVisitSuccessState());
      });
    } catch (error) {
      emit(GetRepVisitErrorState(error));
      rethrow;
    }
  }

  Future getRepVisitCustomer(String id) async {
    emit(GetRepVisitLoadingState());
    try {
      var data = {'customerId': id};
      ApiBaseHelper()
          .get('cash_van/rep_visits', null, body: data)
          .then((value) {
        repVisitsModelList =
            (value as List).map((e) => RepVisitsModel.fromJson(e)).toList();
        getRepVisitReasonsCancellation();
        emit(GetRepVisitSuccessState());
      });
    } catch (error) {
      emit(GetRepVisitErrorState(error));
      rethrow;
    }
  }

  Future getRepVisitReasonsCancellation() async {
    emit(GetRepVisitReasonsLoadingState());
    try {
      ApiBaseHelper()
          .get(
        'cash_van/sales_visit_reasons_cancellation',
        null,
      )
          .then((value) {
        visitReasonsCancellationList = (value as List)
            .map((e) => SalesVisitReasonsCancellationModel.fromJson(e))
            .toList();
        emit(GetRepVisitReasonsSuccessState());
      });
    } catch (error) {
      emit(GetRepVisitReasonsErrorState(error));
      rethrow;
    }
  }

  Future closeVisit(String notes, var attachments) async {
    print(notes);
    if (attachments != null) {
      AuthCubit().uploadImage(imagePath: attachments);
    }
    String url = "cash_van/rep_visits/close";
    await ApiBaseHelper().put(
        url,
        json.encode(
          {
            "id": GetStorage().read('visitId'),
            "user_id": getUser()!.id,
            "notes": notes,
            "attachments": [attachments ?? '']
          },
        ),
        {
          "Authorization": getAuthorization()!,
          'Content-Type': 'application/json'
        }).then((value) {
      emit(CloseVisitSuccessState());

      GetStorage().write("isVisit", false);
      GetStorage().remove("visitName");
      GetStorage().remove("createdAt");
      GetStorage().remove("accountNo");

      Get.to(BottomNavigationScreen(
        index: 1,
      ));
    });
  }

  Future cancelVisit(String cancelId) async {
    final data = json.encode(
        {"visit_id": GetStorage().read('visitId'), "cancel_id": cancelId});

    String url = "cash_van/rep_visits/cancel";
    var response = await ApiBaseHelper().put(url, data, {
      "Authorization": getAuthorization()!,
      'Content-Type': 'application/json'
    }).then((value) async {
      GetStorage().remove('accountNo');
      emit(CancelVisitSuccessState());
    });
  }
}
