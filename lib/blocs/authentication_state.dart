import 'package:equatable/equatable.dart';

enum AuthenticationStatus { loggedIn, notLoggedIn }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;

  const AuthenticationState.loggedIn() : status = AuthenticationStatus.loggedIn;
  const AuthenticationState.notLoggedIn() : status = AuthenticationStatus.notLoggedIn;

  bool get isLoggedIn => status == AuthenticationStatus.loggedIn;

  @override
  List<Object?> get props => [status];
}