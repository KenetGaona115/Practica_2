part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticateInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedSuccessfully extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  @override
  List<Object> get props => [];
}
