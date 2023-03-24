abstract class CustomerMainState {}

class CustomerMainInitialState extends CustomerMainState{}
class GetCustomerLoadingState extends CustomerMainState{}
class GetCustomerSuccessState extends CustomerMainState{}

class GetCustomerErrorState extends CustomerMainState{
  final  error;

  GetCustomerErrorState(this.error);
}

class DeleteCustomerLoadingState extends CustomerMainState{}
class DeleteCustomerSuccessState extends CustomerMainState{}

class DeleteCustomerErrorState extends CustomerMainState{
  final  error;

  DeleteCustomerErrorState(this.error);
}

class InitializeLoadingState extends CustomerMainState{}
class InitializeSuccessState extends CustomerMainState{}

class InitializeErrorState extends CustomerMainState{
  final  error;

  InitializeErrorState(this.error);
}
class GetBondsLoadingState extends CustomerMainState{}
class GetBondsSuccessState extends CustomerMainState{}

class GetBondsErrorState extends CustomerMainState{
  final  error;

  GetBondsErrorState(this.error);
}


class CreateCustomerLoadingState extends CustomerMainState{}
class CreateCustomerSuccessState extends CustomerMainState{}

class CreateCustomerErrorState extends CustomerMainState{
  final  error;

  CreateCustomerErrorState(this.error);
}

class UpdateCustomerLoadingState extends CustomerMainState{}
class UpdateCustomerSuccessState extends CustomerMainState{}

class UpdateCustomerErrorState extends CustomerMainState{
  final  error;

  UpdateCustomerErrorState(this.error);
}


class GetBanksLoadingState extends CustomerMainState{}
class GetBanksSuccessState extends CustomerMainState{}

class GetBanksErrorState extends CustomerMainState{
  final  error;

  GetBanksErrorState(this.error);
}


class UploadImageLoadingState extends CustomerMainState{}
class UploadImageSuccessState extends CustomerMainState{}

class UploadImageErrorState extends CustomerMainState{
  final  error;

  UploadImageErrorState(this.error);
}


class UpdateClientLoadingState extends CustomerMainState{}
class UpdateClientSuccessState extends CustomerMainState{}

class UpdateClientErrorState extends CustomerMainState{
  final  error;

  UpdateClientErrorState(this.error);
}
class GetCustomerIdLoadingState extends CustomerMainState{}
class GetCustomerIdSuccessState extends CustomerMainState{}

class GetCustomerIdErrorState extends CustomerMainState{
  final  error;

  GetCustomerIdErrorState(this.error);
}
