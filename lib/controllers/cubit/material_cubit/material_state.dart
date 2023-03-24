abstract class MaterialMainState {}

class MaterialMainInitialState extends MaterialMainState{}
class GetMaterialLoadingState extends MaterialMainState{}
class GetMaterialSuccessState extends MaterialMainState{}

class GetMaterialErrorState extends MaterialMainState{
  final  error;

  GetMaterialErrorState(this.error);
}

class GetMaterialReportsLoadingState extends MaterialMainState{}
class GetMaterialReportsSuccessState extends MaterialMainState{}

class GetMaterialReportsErrorState extends MaterialMainState{
  final  error;

  GetMaterialReportsErrorState(this.error);
}
class GetCategoryItemLoadingState extends MaterialMainState{}
class GetCategoryItemSuccessState extends MaterialMainState{}

class GetCategoryItemErrorState extends MaterialMainState{
  final  error;

  GetCategoryItemErrorState(this.error);
}
class GetCategorySearchLoadingState extends MaterialMainState{}
