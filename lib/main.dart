import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/biometric/biomatric_bloc.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_evert.dart';
import 'package:vemech/bloc/login/login_bloc.dart';
import 'package:vemech/bloc/profile/profile_bloc.dart';
import 'package:vemech/bloc/signup/signup_bloc.dart';
import 'package:vemech/view/login_view.dart';
import 'package:vemech/view/dashboard_view.dart';
import 'package:vemech/widgets/prefrences_helper.dart'; // Assuming you have a DashboardView

void main() async {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  TokenManager tokenManager = TokenManager();
  String? token = await tokenManager.getToken();

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<BiomatricBloc>(
            create: (context) => BiomatricBloc()
              ..add(
                BiomatricAccess(),
              )),
        // Add other providers here as needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((context) {
                return Colors.green;
              }),
              shape: WidgetStateProperty.resolveWith((context) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                );
              }),
              foregroundColor: WidgetStateProperty.resolveWith((context) {
                return Colors.white;
              }),
            ),
          ),
          useMaterial3: true,
        ),
        home: token != null ? const DashboardView() : const LoginView(),
      ),
    );
  }
}
