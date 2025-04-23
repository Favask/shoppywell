
import 'dart:developer';

import 'package:shoppywell/src/data/repository/authentication_repository_impl.dart';
import 'package:shoppywell/src/domain/repositories/autentication_repository.dart';
import 'package:shoppywell/src/domain/usecase/authentication.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_event.dart';
import 'package:shoppywell/src/presentation/bloc/sign_in_form/sign_in_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitiate()) {
    final AuthenticationUseCase useCase = AuthenticationUseCase();

    on<LoginEvent>((event, emit) {
      emit(AuthStateLoading());
      log("-------------${event.email}");
      log("-------------${event.password}");
      useCase.login(email: event.email, password: event.password,
          onRequestSuccess: (response)
          {
            // emit(LoginSuccessState(response, username: state.username, password: state.password));
          }, onRequestFailure: (Exception exception) {  }
      );
    });

    on<UsernameChanged>((event, emit) => emit(state.copyWith(username: event.username)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
   }
}
