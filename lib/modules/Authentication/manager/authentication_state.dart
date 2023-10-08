part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationPasswordVisibility extends AuthenticationState {
  final bool isPassword;

  AuthenticationPasswordVisibility({required this.isPassword});
}
