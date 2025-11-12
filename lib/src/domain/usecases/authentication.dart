import 'package:shoppywell/src/data/repositories/authentication_repository_impl.dart';
import 'package:shoppywell/src/domain/repositories/autentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository _repository=AuthenticationRepositoryImpl();

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    return await _repository.login(email: email, password: password);
  }
}
