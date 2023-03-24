abstract class AuthMainState {}

class AuthMainInitialState extends AuthMainState{}
class LoginLoadingState extends AuthMainState{}
class LoginSuccessState extends AuthMainState{}

class LoginErrorState extends AuthMainState{
  final  error;

  LoginErrorState(this.error);
}


class SignUpLoadingState extends AuthMainState{}
class SignUpSuccessState extends AuthMainState{}

class SignUpErrorState extends AuthMainState{
  final  error;

  SignUpErrorState(this.error);
}
class SelectCompanyLoadingState extends AuthMainState{}
class SelectCompanySuccessState extends AuthMainState{}

class SelectCompanyErrorState extends AuthMainState{
  final  error;

  SelectCompanyErrorState(this.error);
}


class ChangePassLoadingState extends AuthMainState{}
class ChangePassSuccessState extends AuthMainState{}

class ChangePassErrorState extends AuthMainState{
  final  error;

  ChangePassErrorState(this.error);
}

class UploadImageSuccessState extends AuthMainState{}
