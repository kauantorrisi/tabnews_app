part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/* LOGIN */

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessful extends AuthState {}

class AuthEmailException extends AuthState {}

class AuthPasswordException extends AuthState {}

class AuthError extends AuthState {}

/* REGISTER */

