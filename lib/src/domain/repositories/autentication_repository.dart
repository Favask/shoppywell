import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  void register({
    required String email,
    required String password,
    required Function(dynamic signUpResponse) onRequestSuccess,
    required Function(Exception exception) onRequestFailure,
  });
  
  Future<AuthResult> signInWithGoogle();
  Future<AuthResult> signInWithFacebook();
  Future<void> signOut();
  bool isUserLoggedIn();
  Map<String, dynamic> getUserProfile();
  Stream<User?> get authStateChanges;
}

class AuthResult {
  final User? user;
  final String? errorMessage;
  final dynamic data;
  
  AuthResult({this.user, this.errorMessage, this.data});
  
  bool get isSuccess => errorMessage == null;
}
