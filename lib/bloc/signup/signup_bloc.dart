// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vemech/models/login_model.dart';
// import 'package:vemech/network%20helper/network_helper.dart';



// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final NetworkHelper authService = NetworkHelper();

//   AuthenticationBloc() : super(AuthenticationInitialState()) {
//     // Handle the SignUpUser event
//     on<SignUpUser>((event, emit) async {
//       // Validate email and password
//       if (_validateUser(event.email) == null &&
//           _validatePassword(event.password) == null) {
//         // Emit loading state
//         emit(AuthenticationLoadingState(isLoading: true));

//         try {
//           // API call for login
//           var user = await authService.postLogin(
//             username: event.email,
//             password: event.password,
//           );

//           // Check if the response is successful
//           if (user.statusCode == 200) {
//             // On successful login, emit the success state
//             emit(AuthenticationSuccessState(LoginModel.fromJson(user.body)));
//           } else {
//             // If the response contains an error, emit the failure state
//             String errorMessage = '${jsonDecode(user.body)['error']}';
//             emit(AuthenticationFailureState(errorMessage));
//           }
//         } catch (e) {
//           // Handle any exceptions
//           emit(AuthenticationFailureState('An unexpected error occurred.'));
//         }

//         // Emit loading state as false after the process completes (success or failure)
//         emit(AuthenticationLoadingState(isLoading: false));
//       } else {
//         // If validation fails, emit the validation error states
//         emit(AuthenticationValidationFailureState(
//           emailError: _validateUser(event.email),
//           passwordError: _validatePassword(event.password),
//         ));
//       }
//     });
//   }

//   // Helper method for validating the email
//   String? _validateUser(String email) {
//     if (email.isEmpty) {
//       return 'Please enter your Username';
//     }
//     return null;
//   }

//   // Helper method for validating the email
//   String? _validateEmail(String email) {
//     if (email.isEmpty) {
//       return 'Please enter your email';
//     } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
//         .hasMatch(email)) {
//       return 'Please enter a valid email';
//     }
//     return null;
//   }

//   // Helper method for validating the password
//   String? _validatePassword(String password) {
//     if (password.isEmpty) {
//       return 'Please enter your password';
//     } else if (password.length < 5) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }
// }
