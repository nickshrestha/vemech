import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/workshop_recommendation_model.dart';
import 'package:vemech/network%20helper/base_url.dart';
import 'package:vemech/network%20helper/network_helper.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkHelper networkHelper = NetworkHelper();

  HomeBloc() : super(HomeInitialState()) {
    on<UserHome>(
      (event, emit) async {
        emit(HomeLoadingState(isLoading: true));
        try {
          var response = await networkHelper.getRequest(url: BaseUrl.recommendation);

          if (response.statusCode == 200) {
            List<dynamic> jsonList = jsonDecode(response.body);
            List<WorkshopRecommendationModel> models = jsonList
              .map((jsonItem) => WorkshopRecommendationModel.fromJson(jsonItem))
              .toList();

            emit(HomeLoadingState(isLoading: false));
            emit(HomeSuccessState(models));
          } else {
            emit(HomeLoadingState(isLoading: false));
            String errorMessage = jsonDecode(response.body)['detail'];
            emit(HomeFailureState(errorMessage));
          }
        } catch (e) {
          emit(HomeLoadingState(isLoading: false));
          emit( HomeFailureState('An unexpected error occurred. $e'));
        }
      },
    );
  }
}
