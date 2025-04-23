import 'package:shoppywell/src/data/repository/authentication_repository_impl.dart';
import 'package:shoppywell/src/domain/repositories/autentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository _repository=AuthenticationRepositoryImpl();

  Future<void> login({required String email, required String password,    required Function(dynamic loginResponse) onRequestSuccess,
    required Function(Exception exception) onRequestFailure}) async {
     _repository.login(email: email, password: password, onRequestSuccess: onRequestSuccess, onRequestFailure: onRequestFailure);
  }
}
