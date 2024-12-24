part of 'home_bloc.dart';



abstract class HomeState {
  const HomeState();

  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {
  final bool isLoading;
  HomeLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class HomeSuccessState extends HomeState {
  final List<WorkshopRecommendationModel> homeList;

  const HomeSuccessState(this.homeList);

  @override
  List<Object> get props => [homeList];
}


class HomeFailureState extends HomeState {
  final String errorMessage;

  const HomeFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
