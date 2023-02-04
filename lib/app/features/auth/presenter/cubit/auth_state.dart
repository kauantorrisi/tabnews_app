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

class RegisteredSuccessful extends AuthState {}

class RegisterEmptyUsernameException extends AuthState {}

class RegisterUsernameAlreadyTakenException extends AuthState {}

class RegisterEmailException extends AuthState {}

class RegisterEmailAlreadyTakenException extends AuthState {}

class RegisterPasswordException extends AuthState {}

class RegisterError extends AuthState {}

class RecoveryPasswordLoading extends AuthState {}

class RecoveryPasswordSuccessful extends AuthState {}

class RecoveryPasswordEmailException extends AuthState {}

class RecoveryPasswordEmailNotFoundException extends AuthState {}

class RecoveryPasswordError extends AuthState {}
