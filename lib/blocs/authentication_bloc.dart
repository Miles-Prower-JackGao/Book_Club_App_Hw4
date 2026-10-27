import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.notLoggedIn()) {
    on<LoginRequested>(
        (event, emit) => emit(const AuthenticationState.loggedIn()));
    on<LogoutRequested>(
        (event, emit) => emit(const AuthenticationState.notLoggedIn()));
  }
}