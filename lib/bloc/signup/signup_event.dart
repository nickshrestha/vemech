part of 'signup_bloc.dart';

abstract class SignupEvent {
  const SignupEvent();

  List<Object> get props => [];
}

class SignUpUser extends SignupEvent {
  final String email;
  final String password;
  final String role;
  final String firstName;
  final String lastName;
  final String confirmPassword;
  final String address;
  final String phoneNo;
  final String dob;

  const SignUpUser(
      {required this.email,
      required this.password,
      required this.role,
      required this.firstName,
      required this.lastName,
      required this.confirmPassword,
      required this.address,
      required this.phoneNo,
      required this.dob});

  @override
  List<Object> get props => [email, password];
}
