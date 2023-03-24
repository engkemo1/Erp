abstract class InventoryMainState {}

class InventoryMainInitialState extends InventoryMainState{}
class GetInventoryLoadingState extends InventoryMainState{}
class GetInventorySuccessState extends InventoryMainState{}

class GetInventoryErrorState extends InventoryMainState{
  final  error;

  GetInventoryErrorState(this.error);

}



class GetInventoryIdLoadingState extends InventoryMainState{}
class GetInventoryIdSuccessState extends InventoryMainState{}

class GetInventoryIdErrorState extends InventoryMainState{
  final  error;

  GetInventoryIdErrorState(this.error);
}



