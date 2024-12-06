import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/profile_model.dart';
import 'package:vemech/network%20helper/network_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final NetworkHelper authService = NetworkHelper();

  ProfileBloc() : super(ProfileInitialState()) {
    on<UserProfile>(
      (event, emit) async {
        emit(ProfileLoadingState(isLoading: true));
        try {
          var user = await authService.getProfile();

          if (user.statusCode == 200) {
            emit(ProfileLoadingState(isLoading: false));
            var profileModel = ProfileModel.fromJson(user.body);
            emit(ProfileSucccessState(profileModel));
          } else {
            emit(ProfileLoadingState(isLoading: false));
            // If the response contains an error, emit the failure state
            String errorMessage = '${jsonDecode(user.body)['detail']}';
            emit(ProfileFailureState(errorMessage));
          }
          
        } catch (e) {
          // Handle any exceptions
          emit(ProfileLoadingState(isLoading: false));
          emit(const ProfileFailureState('An unexpected error occurred.'));
        }
      },
    );
  }
}
