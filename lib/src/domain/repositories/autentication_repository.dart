
abstract class AuthenticationRepository {
  void login({
    required String email,
    required String password,
    required Function(dynamic loginResponse) onRequestSuccess,
    required Function(Exception exception) onRequestFailure,
  });

  void register({
    required String email,
    required String password,
    required Function(dynamic signUpResponse) onRequestSuccess,
    required Function(Exception exception) onRequestFailure,
  });
}
