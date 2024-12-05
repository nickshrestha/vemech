part of 'login_bloc.dart';

abstract class AuthenticationState {
  const AuthenticationState();

  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessState extends AuthenticationState {
  final LoginModel user;

  const AuthenticationSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AuthenticationValidationFailureState extends AuthenticationState {
  final String? emailError;
  final String? passwordError;

  const AuthenticationValidationFailureState({
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object> get props => [emailError ?? '', passwordError ?? ''];
}

class AuthenticationLoggedOutState extends AuthenticationState {}