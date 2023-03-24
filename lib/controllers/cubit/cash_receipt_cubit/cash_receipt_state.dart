abstract class CashReceiptMainState {}

class CashReceiptMainInitialState extends CashReceiptMainState{}
class GetCashReceiptLoadingState extends CashReceiptMainState{}
class GetCashReceiptSuccessState extends CashReceiptMainState{}

class GetCashReceiptErrorState extends CashReceiptMainState{
  final  error;

  GetCashReceiptErrorState(this.error);
}


class GetCashReceiptByIdLoadingState extends CashReceiptMainState{}
class GetCashReceiptByIdSuccessState extends CashReceiptMainState{}

class GetCashReceiptByIdErrorState extends CashReceiptMainState{
  final  error;

  GetCashReceiptByIdErrorState(this.error);
}



class UpdateCashReceiptLoadingState extends CashReceiptMainState{}
class UpdateCashReceiptSuccessState extends CashReceiptMainState{}
class UpdateCashReceiptErrorState extends CashReceiptMainState{
  final  error;

  UpdateCashReceiptErrorState(this.error);
}



class CreateCashReceiptLoadingState extends CashReceiptMainState{}
class CreateCashReceiptSuccessState extends CashReceiptMainState{}
class CreateCashReceiptErrorState extends CashReceiptMainState{
  final  error;

  CreateCashReceiptErrorState(this.error);
}

class DeleteCashReceiptLoadingState extends CashReceiptMainState{}
