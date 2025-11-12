import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shoppywell/src/domain/usecases/authentication.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_event.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppywell/src/utilities/constants.dart';
import 'package:shoppywell/src/utilities/shared_prefs_helper.dart';



class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthStateInitiate(username:  '', password: ''))  {
    final AuthenticationUseCase useCase = AuthenticationUseCase();

    on<LoginEvent>((event, emit) async {
      // emit(AuthStateLoading(
      //   username: state.username,
      //   password: state.password,
      // ));
      log("-----------SharedPrefsHelper.getString(Constants.username)--${await SharedPrefsHelper.getString(Constants.username_key)}");
      log("-----------SharedPrefsHelper.getString(Constants.password)--${await SharedPrefsHelper.getString(Constants.password_key)}");
      log("-----------event.email--${event.email}");
      log("-----------event.password--${event.password}");
      try {
        final response = await useCase.login(
          email: event.email,
          password: event.password,
        );
        // Store credentials for auto login
        print("---response--${response.toString()}");
        emit(LoginSuccessState(
          response,
          username: state.username,
          password: state.password,
        ));

        print("---event.email--${event.email}");
        print("---event.password--${event.password}");

        SharedPrefsHelper.setString(Constants.username_key,event.email );
        SharedPrefsHelper.setString(Constants.password_key, event.password);
      } catch (exception) {
        emit(AuthStateInitiate(
          username: state.username,
          password: state.password,
        ));
      }
    });

    on<UsernameChanged>((event, emit) => emit(state.copyWith(username: event.username)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<FacebookLoginEvent>((event, emit) async {
       final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
     UserCredential userCred= await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

     if(userCred.credential?.accessToken != null)
     {
      emit(const LoginSuccessState({"status":"success"}));
     }
    } );
   }
}
