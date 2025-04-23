import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shoppywell/src/domain/repositories/autentication_repository.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  
  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;
  
  // Stream of auth state changes
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  
  @override
  void login({
    required String email,
    required String password,
    required Function(dynamic loginResponse) onRequestSuccess,
    required Function(Exception exception) onRequestFailure,
  }) {
    try {
      // Simulating API call with Future.microtask
      Future.microtask(() {
        // Mock API response (Replace with actual API call)
        // if (email == "test@example.com" && password == "password") {
          onRequestSuccess({"message": "Login successful", "token": "xyz123"});
        // } else {
        //   onRequestFailure(Exception("Invalid credentials"));
        // }
      });
    } catch (e) {
      onRequestFailure(Exception(e.toString()));
    }
  }

  @override
  void register({
    required String email,
    required String password,
    required Function(dynamic signUpResponse) onRequestSuccess,
    required Function(Exception exception) onRequestFailure,
  }) {
    try {
      // Simulating API call with Future.delayed
      Future.delayed(Duration(seconds: 2), () {
        // Mock API response (Replace with actual API call)
          onRequestSuccess({"message": "Registration successful", "userId": 123});
      });
    } catch (e) {
      onRequestFailure(Exception(e.toString()));
    }
  }
  
  // Sign in with Google
  @override
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return AuthResult(errorMessage: "Google sign in was canceled");
      }
      
      // Obtain the auth details from the Google sign in
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Create a new credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
          
      return AuthResult(
        user: userCredential.user,
        data: {"message": "Google login successful", "token": googleAuth.accessToken}
      );
    } catch (e) {
      return AuthResult(errorMessage: e.toString());
    }
  }
  
  // Sign in with Facebook
  @override
  Future<AuthResult> signInWithFacebook() async {
    try {
      // Trigger the Facebook Authentication flow
      final LoginResult result = await _facebookAuth.login();
      
      if (result.status != LoginStatus.success) {
        return AuthResult(errorMessage: "Facebook sign in failed or was canceled");
      }
      
      // Get the access token
      final AccessToken? accessToken = result.accessToken;
      
      if (accessToken == null) {
        return AuthResult(errorMessage: "Facebook access token is null");
      }
      
      // Create a Facebook credential for Firebase
      final OAuthCredential credential = 
          FacebookAuthProvider.credential(accessToken.tokenString );
          
      // Sign in to Firebase with the Facebook credential
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
          
      return AuthResult(
        user: userCredential.user,
        data: {"message": "Facebook login successful", "token": accessToken.tokenString}
      );
    } catch (e) {
      return AuthResult(errorMessage: e.toString());
    }
  }
  
  // Sign out
  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
    } catch (e) {
      throw Exception("Error signing out: $e");
    }
  }
  
  // Get user profile data
  @override
  Map<String, dynamic> getUserProfile() {
    final User? user = currentUser;
    if (user == null) {
      return {};
    }
    
    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'phoneNumber': user.phoneNumber,
      'emailVerified': user.emailVerified,
      'isAnonymous': user.isAnonymous,
      'providerData': user.providerData.map((provider) => {
        'providerId': provider.providerId,
        'uid': provider.uid,
        'displayName': provider.displayName,
        'email': provider.email,
        'phoneNumber': provider.phoneNumber,
        'photoURL': provider.photoURL,
      }).toList(),
    };
  }
  
  // Check if user is logged in
  @override
  bool isUserLoggedIn() {
    return currentUser != null;
  }
}