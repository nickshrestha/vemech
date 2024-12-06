import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/models/login_model.dart';
import 'package:vemech/network%20helper/network_helper.dart';
import 'package:vemech/widgets/prefrences_helper.dart';
import 'package:local_auth/local_auth.dart';

part 'biomatric_event.dart';
part 'biomatric_state.dart';

class BiomatricBloc extends Bloc<BiomatricEvent, BiomatricState> {
  final NetworkHelper authService = NetworkHelper();
  TokenManager tokenManager = TokenManager();
  final LocalAuthentication _localAuth = LocalAuthentication();
  BiomatricBloc() : super(BiomatricInitialState()) {
    // Handle the LogOutUser event
    on<BiomatricAccess>((event, emit) async {
      // Emit loading state
      emit(BiomatricLoadingState(isLoading: true));

      try {
        var boolvalue = await _localAuth.canCheckBiometrics;
        if (boolvalue == true) {
          emit(BiomatricLoadingState(isLoading: false));
          emit(BiomatricSuccessState(boolvalue));
        } else {
          emit(BiomatricLoadingState(isLoading: false));
          emit(BiomatricFailureState(boolvalue));
        }
      } catch (e) {
        emit(BiomatricLoadingState(isLoading: false));
        emit(const BiomatricFailureState(false));
      }
    });
    on<BiomatricLogin>((event, emit) async {
      // Emit loading state
      emit(BiomatricLoadingState(isLoading: true));
      print("here is the biomatric 1");

      try {
        print("here is the biomatric 2 ");
        var boolvalue = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to login',
          options: const AuthenticationOptions(
            stickyAuth: true, // Prevents authentication from being interrupted
          ),
        );

        if (boolvalue == true) {
          var username = await tokenManager.getUsername();
          var password = await tokenManager.getPassword();
          var user = await authService.postLogin(
            username: username!,
            password: password!,
          );
          if (user.statusCode == 200) {
            // On successful login, emit the success state
            var loginModel = LoginModel.fromJson(user.body);

            await tokenManager.saveToken(loginModel.token);
            emit(BiomatricLoadingState(isLoading: false));

            emit(BiomatricSuccessState(boolvalue));
          } else {
            // If the response contains an error, emit the failure state
            // String errorMessage = '${jsonDecode(user.body)['error']}';
            emit(BiomatricLoadingState(isLoading: false));
            emit(BiomatricFailureState(boolvalue));
          }
        } else {
          print("here is the biomatric 3");
          emit(BiomatricLoadingState(isLoading: false));
          emit(BiomatricFailureState(boolvalue));
        }
      } catch (e) {
        print("here is the biomatric 4");
        emit(BiomatricLoadingState(isLoading: false));
        emit(const BiomatricFailureState(false));
      }
    });
  }
}
