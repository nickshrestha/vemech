import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/login_model.dart';
import 'package:vemech/network%20helper/network_helper.dart';
import 'package:vemech/widgets/validation.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final NetworkHelper authService = NetworkHelper();

  SignupBloc() : super(SignupInitialState()) {
    // Handle the SignUpUser event
    on<SignUpUser>((event, emit) async {
      // Validate email and password
      if (Validation().validateUser(event.email) == null) {
        // Emit loading state
        emit(SignupLoadingState(isLoading: true));

        try {
          // API call for login
          var user = await authService.postSignUp(
            username: event.email,
            password: event.password,
            role: event.role,
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            confirmPassword: event.confirmPassword,
            address: event.address,
            phoneNo: event.phoneNo,
            dob: event.dob,
          );

          // Check if the response is successful
          if (user.statusCode == 201) {
            // On successful login, emit the success state
            String message = '${jsonDecode(user.body)['data']}';
            emit(SignupSuccessState(message));
          } else {
            // If the response contains an error, emit the failure state
            String errorMessage =
                '${jsonDecode(user.body)['non_field_errors'][0]}';
            emit(SignupFailureState(errorMessage));
          }
        } catch (e) {
          // Handle any exceptions
          emit(SignupFailureState('An unexpected error occurred.'));
        }

        // Emit loading state as false after the process completes (success or failure)
        emit(SignupLoadingState(isLoading: false));
      } else {
        // If validation fails, emit the validation error states
        emit(SignupValidationFailureState(
          emailError: Validation().validateUser(event.email),
          passwordError: Validation().validatePassword(event.password),
        ));
      }
    });
  }
}
