import 'package:firstprojects/controllers/cubit/reports_cubit/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/cash receipt model/cash_receipt_model.dart';
import '../../../models/invoices_model/invoices_model.dart';

class ReportsCubit extends Cubit<ReportMainState> {
  ReportsCubit() : super(ReportMainInitialState());

  static ReportsCubit get(context) => BlocProvider.of(context);

  bool isGetReceiptLoading = false;

  Future<List<InvoicesModel>> getInvoices(
      int screenId,
      var id, String endDate, String startDate, String salesId) async   {
    emit(GetInvoicesLoadingState());
    List<InvoicesModel> invoiceModelList = [];

    var body={
      'accountId':salesId,
      'startDate':startDate,
      'endDate':endDate,
      'salesmanId':id.toString(),
    };
    try {
      String url =
          screenId==1?"inventory/invoices":screenId==2?"inventory/return_invoices":"inventory/purchases_orders";
    await ApiBaseHelper().get(url,null,body: body).then((value) {
      invoiceModelList = [];
        value.forEach((object) {
          invoiceModelList.add(InvoicesModel.fromJson(object));
        });

      });

      emit(GetInvoicesSuccessState());
      return invoiceModelList;
    } catch (ex) {
      emit(GetInvoicesErrorState(ex));
      rethrow;
    }

  }

  Future<List<CashReceiptModel>> getCatchReceipt(
      var id, String endDate, String startDate, String salesId) async {
    List<CashReceiptModel> cashReceiptModelList = [];
    emit(GetCashReceiptLoadingState());
    try {
      var body={"accountId":id,"startDate":startDate,"endDate":endDate,"salesmanId":salesId};
      String url =
          "accounting/cashReceipts";
      var response = await ApiBaseHelper().get(url,body: body,null).then((value) {
        cashReceiptModelList=[];
        value.forEach((object) {
          cashReceiptModelList.add(CashReceiptModel.fromJson(object));
        });
      });

      emit(GetCashReceiptSuccessState());
      return cashReceiptModelList;
    } catch (ex) {
      emit(GetCashReceiptErrorState(ex));
      rethrow;
    }
  }

}
