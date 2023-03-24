abstract class RepVisitsMainState {}

class RepVisitsMainInitialState extends RepVisitsMainState{}
class CloseVisitSuccessState extends RepVisitsMainState{}
class AddVisitSuccessState extends RepVisitsMainState{}
class CancelVisitSuccessState extends RepVisitsMainState{}

class GetRepVisitLoadingState extends RepVisitsMainState{}

class GetRepVisitSuccessState extends RepVisitsMainState{

}
class GetRepVisitErrorState extends RepVisitsMainState{
  final error;

  GetRepVisitErrorState(this.error);

}

class GetRepVisitReasonsLoadingState extends RepVisitsMainState{}

class GetRepVisitReasonsSuccessState extends RepVisitsMainState{

}
class GetRepVisitReasonsErrorState extends RepVisitsMainState{
  final error;

  GetRepVisitReasonsErrorState(this.error);

}

