abstract class PrepareGoodsMainState {}

class PrepareGoodsMainInitialState extends PrepareGoodsMainState{}
class GetPrepareGoodsLoadingState extends PrepareGoodsMainState{}
class GetPrepareGoodsSuccessState extends PrepareGoodsMainState{}

class GetPrepareGoodsErrorState extends PrepareGoodsMainState{
  final  error;

  GetPrepareGoodsErrorState(this.error);
}


