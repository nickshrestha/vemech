part of 'signup_bloc.dart';

abstract class SignupEvent {
  const SignupEvent();

  List<Object> get props => [];
}

class SignUpUser extends SignupEvent {
  final String email;
  final String username;
  final String password;
  final String role;
  final String firstName;
  final String lastName;
  final String confirmPassword;
  final String address;
  final String phoneNo;
  final String dob;
  final String? workshopname;
  final String? catagory;
  final String? panNo;

  const SignUpUser(
      {required this.email,
      required this.username, 
      required this.password,
      required this.role,
      required this.firstName,
      required this.lastName,
      required this.confirmPassword,
      required this.address,
      required this.phoneNo,
      required this.dob ,this.workshopname, this.catagory, this.panNo, });

  @override
  List<Object> get props => [email, password];
}

class UserName extends SignupEvent {}

class Email extends SignupEvent {}
