abstract class StoresMainState {}

class StoresMainInitialState extends StoresMainState{}
class GetStoresLoadingState extends StoresMainState{}
class GetStoresSuccessState extends StoresMainState{}

class GetStoresErrorState extends StoresMainState{
  final  error;

  GetStoresErrorState(this.error);
}


