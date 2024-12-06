part of 'biomatric_bloc.dart';

abstract class BiomatricState {
  const BiomatricState();

  List<Object> get props => [];
}

class BiomatricInitialState extends BiomatricState {}

class BiomatricLoadingState extends BiomatricState {
  final bool isLoading;

  BiomatricLoadingState({required this.isLoading});
}



class BiomatricFailureState extends BiomatricState {
   final bool isLoading;

  const BiomatricFailureState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}


class BiomatricSuccessState extends BiomatricState {
  final bool isLoading;

  const BiomatricSuccessState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}
