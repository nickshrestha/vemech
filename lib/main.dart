import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_evert.dart';
import 'package:vemech/bloc/login/login_bloc.dart';
import 'package:vemech/bloc/signup/signup_bloc.dart';
import 'package:vemech/view/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                // Return green for all states
                return Colors.green;
              }),
              shape: WidgetStateProperty.resolveWith((context) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Adjust radius
                );
              }),
              foregroundColor: WidgetStateProperty.resolveWith((context) {
                return Colors.white;
              }),
            ),
          ),
          useMaterial3: true,
        ),
        home: LoginView(), // Starting point of the app
      ),
    );
  }
}
