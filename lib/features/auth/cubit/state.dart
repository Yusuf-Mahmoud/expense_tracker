
import 'package:expense_tracker/core/firebase/model/user.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final UserModel info;
  LoginSuccess(this.info);
}

class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}
