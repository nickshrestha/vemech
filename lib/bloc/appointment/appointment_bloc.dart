import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/list_workshops_time_schedule_model.dart';
import 'package:vemech/models/workshop_recommendation_model.dart';
import 'package:vemech/network%20helper/base_url.dart';
import 'package:vemech/network%20helper/network_helper.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final NetworkHelper networkHelper = NetworkHelper();

  AppointmentBloc() : super(AppointmentInitialState()) {
    on<WorkshopsLsit>(
      (event, emit) async {
        emit(AppointmentLoadingState(isLoading: true));
        try {
          var response = await networkHelper.getRequest(
              url: BaseUrl.appointmentAvailability);

          if (response.statusCode == 200) {
           List<ListWorkshopsTimeSchedule> workshops = listWorkshopsTimeScheduleFromJson(response.body);

            emit(AppointmentLoadingState(isLoading: false));
            emit(AppointmentSuccessState(workshops));
          } else {
            emit(AppointmentLoadingState(isLoading: false));
            // String errorMessage = jsonDecode(response.body)['detail'];
            emit(const AppointmentFailureState("failed to get list "));
          }
        } catch (e) {
          print("this is errror on fetching appoint ment : $e");
          emit(AppointmentLoadingState(isLoading: false));
          emit(const AppointmentFailureState("error fetching "));
        }
      },
    );
  }
}
