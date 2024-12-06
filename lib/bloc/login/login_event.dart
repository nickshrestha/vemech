part of 'login_bloc.dart';



abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];

}

class SignUpUser extends AuthenticationEvent {
  final String email;
  final String password;
  final bool issaved;

  const SignUpUser(this.email, this.password, this.issaved);

  @override
  List<Object> get props => [email, password, issaved];
}



class ChangePassword extends AuthenticationEvent {
  final String currentPassword;
  final String newPassword;
  final String conformPassword;
  const ChangePassword(this.currentPassword, this.newPassword, this.conformPassword);
  @override
  List<Object> get props => [currentPassword, newPassword, conformPassword];
  
}


class LogOutUser extends AuthenticationEvent {}
