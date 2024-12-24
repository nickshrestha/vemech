part of 'edit_profile_bloc.dart';

abstract class EditProfileState {
  const EditProfileState();

  List<Object> get props => [];
}

class EditProfileInitialState extends EditProfileState {}
class EditProfileLoadingState extends EditProfileState {
  final bool isLoading;
  EditProfileLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class EditProfileSucccessState extends EditProfileState {
  final String successMessage;

  const EditProfileSucccessState(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class EditProfileFailureState extends EditProfileState {
  final String errorMessage;

  const EditProfileFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
