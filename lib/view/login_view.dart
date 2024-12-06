import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/biometric/biomatric_bloc.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_state.dart';
import 'package:vemech/bloc/login/login_bloc.dart';
import 'package:vemech/view/dashboard_view.dart';
import 'package:vemech/view/registration_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSelected = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController.text = "nikhil1";
    passwordController.text = "admin@123";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 50),
                  BlocListener<NetworkBloc, NetworkState>(
                    listener: (context, state) {
                      if (state is NetworkFailure) {
                        // When no internet connection, show a snackbar or alert
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No Internet Connection"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is NetworkSuccess) {
                        // When connected to the internet, you can trigger a page refresh
                        // You can perform any action like reloading data or UI refresh
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("You're connected to the internet"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<NetworkBloc, NetworkState>(
                      builder: (context, state) {
                        // Here you can directly update the UI based on connection status
                        if (state is NetworkFailure) {
                          return const SizedBox.shrink();
                        } else if (state is NetworkSuccess) {
                          return const SizedBox.shrink();
                        } else {
                          return const SizedBox.shrink(); // Empty state
                        }
                      },
                    ),
                  ),

                  // Text: Sign in to your account
                  const Text(
                    'Sign in to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Logo image
                  Image.network(
                    "https://cdn.vectorstock.com/i/1000v/38/48/sport-car-logo-design-fast-silhouette-icon-vector-48573848.jpg",
                    // 'assets/car_logo.png', // Replace with your image asset path
                    height: 100,
                  ),
                  const SizedBox(height: 40),
                  // Username field
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password field
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 5) {
                        return 'Password must be at least 5 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            isSelected = value!;
                          });
                        },
                      ),
                      const Text("Use Biomatric for Login next time.")
                    ],
                  ),

                 Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust the alignment of buttons
  children: [
    // Sign Up Button
    BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardView(),
            ),
          );
        } else if (state is AuthenticationFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthenticationValidationFailureState) {
          // Show validation error messages from Bloc
          if (state.emailError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.emailError!),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.passwordError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.passwordError!),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Trigger authentication only if the form is valid
                BlocProvider.of<AuthenticationBloc>(context).add(
                  SignUpUser(
                    emailController.text,
                    passwordController.text,
                    isSelected,
                  ),
                );
              }
            },
            child: Text(
              state is AuthenticationLoadingState && state.isLoading
                  ? '.......'
                  : 'Sign Up',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    ),
    
    const SizedBox(width: 20), // Add some space between buttons
    
    // Biometrics Button (Fingerprint)
    BlocConsumer<BiomatricBloc, BiomatricState>(
      listener: (context, state) {
        print("this is state $state");
        if (state is BiomatricSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardView(),
            ),
          );
        }
      },
      builder: (context, state) {
        print("this is state $state");
        if (state is BiomatricSuccessState) {
          return ElevatedButton(
            onPressed: () {
              // Trigger biometrics authentication when the fingerprint button is pressed
              BlocProvider.of<BiomatricBloc>(context)
                  .add(const BiomatricLogin("asbskjb"));
            },
            child: const Icon(Icons.fingerprint_rounded),
          );
        } else if (state is BiomatricFailureState) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    ),
  ],
),

                  const SizedBox(height: 20),
                  // Forgot Password link
                  TextButton(
                    onPressed: () {
                      // Add your forgot password logic here
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Don't have an account? SIGN UP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          // Add your sign up navigation logic here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationForm()));
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
