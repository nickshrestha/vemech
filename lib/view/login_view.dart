import 'package:flutter/material.dart';
import 'package:vemech/view/dashboard_view.dart';
import 'package:vemech/view/registration_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 50),
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              // Sign in button
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  DashboardView()));
                },
                style: ElevatedButton.styleFrom(
                  // primary: Colors.green, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                  ),
                ),
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
                              builder: (context) => RegistrationForm()));
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
    );
  }
}
