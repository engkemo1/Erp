abstract class ReportMainState {}

class ReportMainInitialState extends ReportMainState{}
class GetInvoicesLoadingState extends ReportMainState{}
class GetInvoicesSuccessState extends ReportMainState{}

class GetInvoicesErrorState extends ReportMainState{
  final  error;

  GetInvoicesErrorState(this.error);
}


class GetCashReceiptLoadingState extends ReportMainState{}
class GetCashReceiptSuccessState extends ReportMainState{}

class GetCashReceiptErrorState extends ReportMainState{
  final  error;

  GetCashReceiptErrorState(this.error);
}
