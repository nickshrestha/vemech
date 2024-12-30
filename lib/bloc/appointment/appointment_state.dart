part of 'appointment_bloc.dart';

abstract class AppointmentState {
  const AppointmentState();
  List<Object> get props => [];
}

class AppointmentInitialState extends AppointmentState {}

class AppointmentLoadingState extends AppointmentState {
  final bool isLoading;

  AppointmentLoadingState({required this.isLoading});
}

class AppointmentFailureState extends AppointmentState {
  final String message;

  const AppointmentFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class AppointmentSuccessState extends AppointmentState {
  final  List<ListWorkshopsTimeSchedule>  workshoplist;

  const AppointmentSuccessState(this.workshoplist);

  @override
  List<Object> get props => [workshoplist];
}
