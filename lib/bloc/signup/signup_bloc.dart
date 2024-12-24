import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/email_list_model.dart';
import 'package:vemech/models/login_model.dart';
import 'package:vemech/models/user_model.dart';
import 'package:vemech/network%20helper/base_url.dart';
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
            username: event.username,
            password: event.password,
            role: event.role,
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            confirmPassword: event.confirmPassword,
            address: event.address,
            phoneNo: event.phoneNo,
            dob: event.dob,
            workshopname:  event.workshopname,
            catagory:  event.catagory,
            panNo:  event.panNo,
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
          print("error is is $e");
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

     on<UserName>(
      (event, emit) async {
        emit(UserLoadingState(isLoading: true));
        try {
          var response = await authService.getRequestwithoutauth(url: BaseUrl.username);

          if (response.statusCode == 200) {
            var jsondata = jsonDecode(response.body);
            // var models =UserNameModel.fromJson(response.body);
             UserNameModel models = UserNameModel.fromJson(jsondata);

            emit(UserLoadingState(isLoading: false));
            emit(UserSuccessState(models));
          } else {
            emit(UserLoadingState(isLoading: false));
            String errorMessage = jsonDecode(response.body)['detail'];
            emit(UserNameFailureState(errorMessage));
          }
        } catch (e) {
          print("erron in adding Emali and user $e");
          emit(UserLoadingState(isLoading: false));
          emit( UserNameFailureState('An unexpected error occurred. $e'));
        }
      },
    );
     on<Email>(
      (event, emit) async {
        emit(UserLoadingState(isLoading: true));
        try {
          var response = await authService.getRequestwithoutauth(url: BaseUrl.email);

          if (response.statusCode == 200) {
            var jsondata = jsonDecode(response.body);
            // var models =UserNameModel.fromJson(response.body);
             EmailModel models = EmailModel.fromJson(jsondata);

            emit(UserLoadingState(isLoading: false));
            emit(EmailSuccessState(models));
          } else {
            emit(UserLoadingState(isLoading: false));
            String errorMessage = jsonDecode(response.body)['detail'];
            emit(UserNameFailureState(errorMessage));
          }
        } catch (e) {
          emit(UserLoadingState(isLoading: false));
          emit( UserNameFailureState('An unexpected error occurred. $e'));
        }
      },
    );
  }
}
