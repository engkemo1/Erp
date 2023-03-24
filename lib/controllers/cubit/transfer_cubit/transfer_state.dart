abstract class TransferMainState {}

class TransferMainInitialState extends TransferMainState{}
class GetTransferLoadingState extends TransferMainState{}
class GetTransferSuccessState extends TransferMainState{}

class GetTransferErrorState extends TransferMainState{
  final  error;

  GetTransferErrorState(this.error);
}


