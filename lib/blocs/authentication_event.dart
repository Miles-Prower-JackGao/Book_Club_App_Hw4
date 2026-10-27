sealed class AuthenticationEvent {}
class LoginRequested extends AuthenticationEvent {}
class LogoutRequested extends AuthenticationEvent {}