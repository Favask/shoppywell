import 'package:shoppywell/src/data/repository/authentication_repository_impl.dart';
import 'package:shoppywell/src/domain/repositories/autentication_repository.dart';

class Authentication {
  final AuthenticationRepository _repository=AuthenticationRepositoryImpl();

  Future<void> login(String email, String password) async {
    return  _repository.login(email: email, password: password, onRequestSuccess: (response) {}, onRequestFailure: (exception) {});
  }
}
