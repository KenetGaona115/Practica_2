part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginWithEmail extends AuthenticationEvent {
  final String username;
  final String password;

  LoginWithEmail({@required this.username, @required this.password});
  @override
  List<Object> get props => [username, password];
}

class LoginWithGoogle extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}

class LogOut extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}

class VerifyAuthenticatedUser extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}
