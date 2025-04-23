abstract class AuthState {
  final String username;
  final String password;

  const AuthState({this.username = '', this.password = ''});

  AuthState copyWith({
    String? username,
    String? password,
  });
}

class AuthStateInitiate extends AuthState {
  const AuthStateInitiate({String username = '', String password = ''})
      : super(username: username, password: password);

  @override
  AuthState copyWith({String? username, String? password}) {
    return AuthStateInitiate(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading({String username = '', String password = ''})
      : super(username: username, password: password);

  @override
  AuthState copyWith({String? username, String? password}) {
    return AuthStateLoading(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

class LoginSuccessState extends AuthState {
  final Map<String, dynamic> loginResponse;

  const LoginSuccessState(
    this.loginResponse, {
    String username = '',
    String password = '',
  }) : super(username: username, password: password);

  @override
  AuthState copyWith({String? username, String? password}) {
    return LoginSuccessState(
      loginResponse,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

class LoginResponseState extends AuthState {
  final Map<String, dynamic> loginResponse;

  const LoginResponseState(
    this.loginResponse, {
    String username = '',
    String password = '',
  }) : super(username: username, password: password);

  @override
  AuthState copyWith({String? username, String? password}) {
    return LoginResponseState(
      loginResponse,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

class SignUpResponseState extends AuthState {
  final Map<String, dynamic> signUpResponse;

  const SignUpResponseState(
    this.signUpResponse, {
    String username = '',
    String password = '',
  }) : super(username: username, password: password);

  @override
  AuthState copyWith({String? username, String? password}) {
    return SignUpResponseState(
      signUpResponse,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
