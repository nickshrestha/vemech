import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/login_model.dart';
import 'package:vemech/network%20helper/network_helper.dart';
import 'package:vemech/widgets/prefrences_helper.dart';
import 'package:vemech/widgets/validation.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final NetworkHelper authService = NetworkHelper();
  TokenManager tokenManager = TokenManager();

  AuthenticationBloc() : super(AuthenticationInitialState()) {
    // Handle the SignUpUser event
    on<SignUpUser>((event, emit) async {
      // Validate email and password
      if (Validation().validateUser(event.email) == null &&
          Validation().validatePassword(event.password) == null) {
        // Emit loading state
        emit(AuthenticationLoadingState(isLoading: true));

        try {
          // API call for login
          var user = await authService.postLogin(
            username: event.email,
            password: event.password,
          );

          // Check if the response is successful
          if (user.statusCode == 200) {
            // On successful login, emit the success state
            var loginModel = LoginModel.fromJson(user.body);
            if (event.issaved) {
              print("inside save token ");
              await tokenManager.manageCredentials(
                  action: "save", username: event.email, password: event.password);
            }
            await tokenManager.saveToken(loginModel.token);
            emit(AuthenticationSuccessState(loginModel));
          } else {
            // If the response contains an error, emit the failure state
            String errorMessage = '${jsonDecode(user.body)['error']}';
            emit(AuthenticationFailureState(errorMessage));
          }
        } catch (e) {
          // Handle any exceptions
          emit(const AuthenticationFailureState(
              'An unexpected error occurred.'));
        }

        // Emit loading state as false after the process completes (success or failure)
        emit(AuthenticationLoadingState(isLoading: false));
      } else {
        // If validation fails, emit the validation error states
        emit(AuthenticationValidationFailureState(
          emailError: Validation().validateUser(event.email),
          passwordError: Validation().validatePassword(event.password),
        ));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(ChangePasswordIsLoading(isloading: true));
      try {
           var response = await authService.postChangePassword(
            currentPassword: event.currentPassword,
            newPassword: event.newPassword,
            confirmPassword: event.conformPassword,
          );
          if(response.statusCode == 200 ) {
            emit(const ChangePasswordIsLoading(isloading: false));
             String message = '${jsonDecode(response.body)['message']}';
           
            emit(ChangePasswordSuccess(message: message));
          }

      }catch(e){
        emit(ChangePasswordFaliure(errorMessage: e.toString()));
      }

    });

    // Handle the LogOutUser event
    on<LogOutUser>((event, emit) async {
      // Emit loading state
      emit(AuthenticationLoadingState(isLoading: true));

      try {
        // API call for login
        await authService.postLogout();
        // Clear the token from SharedPreferences
        await tokenManager.clearToken();

        // Emit success state when logged out
        emit(AuthenticationLoggedOutState());
      } catch (e) {
        // Handle any errors during logout
        emit(const AuthenticationFailureState('An unexpected error occurred.'));
      }

      // Emit loading state as false after the logout process
      emit(AuthenticationLoadingState(isLoading: false));
    });
  }
}
