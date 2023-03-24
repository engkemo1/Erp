abstract class ExpensesMainState {}

class ExpensesMainInitialState extends ExpensesMainState{}
class GetExpensesLoadingState extends ExpensesMainState{}
class GetExpensesSuccessState extends ExpensesMainState{}

class GetExpensesErrorState extends ExpensesMainState{
  final  error;

  GetExpensesErrorState(this.error);
}


class UpdateExpensesLoadingState extends ExpensesMainState{}
class UpdateExpensesSuccessState extends ExpensesMainState{}

class UpdateExpensesErrorState extends ExpensesMainState{
  final  error;

  UpdateExpensesErrorState(this.error);
}
class CreateExpensesLoadingState extends ExpensesMainState{}
class CreateExpensesSuccessState extends ExpensesMainState{}

class CreateExpensesErrorState extends ExpensesMainState{
  final  error;

  CreateExpensesErrorState(this.error);
}
class GetExpensesSearchLoadingState extends ExpensesMainState{}
