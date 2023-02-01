part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginEmailException extends AuthState {}

class LoginPasswordException extends AuthState {}

class LoginError extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {}

class RecoveryPasswordLoading extends AuthState {}

class RecoveryPasswordError extends AuthState {}
