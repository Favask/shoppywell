// Define Events
abstract class AuthEvent {}

class UsernameChanged extends AuthEvent {
  final String username;
  UsernameChanged(this.username);
}

class PasswordChanged extends AuthEvent {
  final String password;
  PasswordChanged(this.password);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  SignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
