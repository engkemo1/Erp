abstract class SalesManMainState {}

class SalesManMainInitialState extends SalesManMainState{}
class GetSalesManLoadingState extends SalesManMainState{}
class GetSalesManSuccessState extends SalesManMainState{}

class GetSalesManErrorState extends SalesManMainState{
  final  error;

  GetSalesManErrorState(this.error);
}


class GetInitializeSalesLoadingState extends SalesManMainState{}
class GetInitializeSalesSuccessState extends SalesManMainState{}

class GetInitializeSalesErrorState extends SalesManMainState{
  final  error;

  GetInitializeSalesErrorState(this.error);
}


class UpdateSalesManLoadingState extends SalesManMainState{}
class UpdateSalesManSuccessState extends SalesManMainState{}

class UpdateSalesManErrorState extends SalesManMainState{
  final  error;

  UpdateSalesManErrorState(this.error);
}
