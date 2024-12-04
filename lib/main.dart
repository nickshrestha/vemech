import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_evert.dart';
import 'package:vemech/bloc/login/login_bloc.dart';
import 'package:vemech/view/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.green,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((context) {
                // Return green for all states
                return Colors.green;
              }),
              shape: WidgetStateProperty.resolveWith((context) {
                // Return RoundedRectangleBorder with less border radius
                return RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust this radius
                );
              }),
              foregroundColor: WidgetStateProperty.resolveWith((context) {
                // Return white text color for all states
                return Colors.white;
              }),
            ),
          ),

          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<NetworkBloc>(
              create: (context) => NetworkBloc()..add(NetworkObserve()),
            ),
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(),
            ),
            // Add other providers here as needed
          ],
          child: LoginView(),
        ));

    //  const LoginView());
  }
}
