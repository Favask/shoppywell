
abstract class AuthState {
  late final String username;
  late final String password;

  AuthState({this.username = '', this.password = ''});
}

class AuthStateInitiate extends AuthState {}

class AuthStateLoading extends AuthState {}

class LoginSuccessState extends AuthState {
  final Map<String, dynamic> loginResponse;
  LoginSuccessState(this.loginResponse, {String username = '', String password = ''})
      : super(username: username, password: password);
}

class LoginResponseState extends AuthState {
  final Map<String, dynamic> loginResponse;
  LoginResponseState(this.loginResponse, {String username = '', String password = ''})
      : super(username: username, password: password);
}

class SignUpResponseState extends AuthState {
  final Map<String, dynamic> signUpResponse;
  SignUpResponseState(this.signUpResponse, {String username = '', String password = ''})
      : super(username: username, password: password);
}