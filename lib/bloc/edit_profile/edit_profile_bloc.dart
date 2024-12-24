import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/profile_model.dart';
import 'package:vemech/network%20helper/base_url.dart';
import 'package:vemech/network%20helper/network_helper.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final NetworkHelper authService = NetworkHelper();

  EditProfileBloc() : super(EditProfileInitialState()) {


    on<EditUserProfile>((event, emit) async {
      // Validate email and password
      // if (Validation().validateUser(event.email) == null) {
      // Emit loading state
      emit(EditProfileLoadingState(isLoading: true));

      try {
        // API call for login
        var body = (event.role == "Workshop")
            ? {
                "workshop_name": event.workshopname,
                // "pan_no": event.panNo,
                "category": event.catagory
              }
            : {
                "address": event.address,
                "phone_no": event.phoneNo,
                "dob": event.dob,
              };
        var response = await authService
            .putRequestwithAuth(body: body, url: BaseUrl.editUserProfile);

        // Check if the response is successful
        if (response.statusCode >= 200 && response.statusCode < 300) {
          // On successful login, emit the success state
          String message = '${jsonDecode(response.body)['Message']}';
          emit(EditProfileSucccessState(message));
        } else {
          // If the response contains an error, emit the failure state
          String errorMessage =
              '${jsonDecode(response.body)['non_field_errors'][0]}';
          emit(EditProfileFailureState(errorMessage));
        }
      } catch (e) {
        print("error is is $e");
        // Handle any exceptions
        emit(EditProfileFailureState('An unexpected error occurred  $e.'));
      }

      // Emit loading state as false after the process completes (success or failure)
      emit(EditProfileLoadingState(isLoading: false));
      // } else {
      //   // If validation fails, emit the validation error states
      //   emit(SignupValidationFailureState(
      //     emailError: Validation().validateUser(event.email),
      //     passwordError: Validation().validatePassword(event.password),
      //   ));
      // }
    });
  }
}
