part of 'profile_bloc.dart';

abstract class ProfileState {
  const ProfileState();

  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {
  final bool isLoading;
  ProfileLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class ProfileSucccessState extends ProfileState {
  final ProfileModel profile;

  const ProfileSucccessState(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileFailureState extends ProfileState {
  final String errorMessage;

  const ProfileFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
