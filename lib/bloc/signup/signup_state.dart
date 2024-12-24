part of 'signup_bloc.dart';

abstract class SignupState {
  const SignupState();

  List<Object> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {
  final bool isLoading;

  SignupLoadingState({required this.isLoading});
}

class SignupSuccessState extends SignupState {
  final String message;

  const SignupSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

class SignupFailureState extends SignupState {
  final String errorMessage;

  const SignupFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class SignupValidationFailureState extends SignupState {
  final String? emailError;
  final String? passwordError;

  const SignupValidationFailureState({
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object> get props => [emailError ?? '', passwordError ?? ''];
}

// User state
class UserLoadingState extends SignupState {
  final bool isLoading;
  UserLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class UserSuccessState extends SignupState {
  final UserNameModel userList;

  const UserSuccessState(this.userList);

  @override
  List<Object> get props => [userList];
}
class EmailSuccessState extends SignupState {
  final EmailModel emailList;

  const EmailSuccessState(this.emailList);

  @override
  List<Object> get props => [emailList];
}


class UserNameFailureState extends SignupState {
  final String errorMessage;

  const UserNameFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
