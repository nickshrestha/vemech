import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/signup/signup_bloc.dart';
import 'package:vemech/view/login_view.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String? selectedRole; // Role selection
  List<String> roles = ['Vehicle_Owner', 'Workshop']; // Example roles

  @override
  void dispose() {
    // Dispose controllers when the widget is destroyed
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // First and Last Name fields in a Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Username field
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dropdown for role selection
              DropdownButtonFormField<String>(
                value: selectedRole,
                hint: const Text('Select Role'),
                onChanged: (newValue) {
                  setState(() {
                    selectedRole = newValue;
                  });
                },
                items: roles.map((role) {
                  return DropdownMenuItem(
                    child: Text(role),
                    value: role,
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone number field
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: TextEditingController(text: '+977'),
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Country Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: phoneNumberController,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Password field
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm password field
              TextFormField(
                controller: confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Address field
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date of birth field
              TextFormField(
                controller: dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                keyboardType: TextInputType.datetime,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Terms and conditions checkbox
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Expanded(
                      child: Text('I agree to the terms and policy')),
                ],
              ),
              const SizedBox(height: 16),

              // Register button

              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccessState) {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DashboardView(),
                    //   ),
                    // );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(state.message),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.done))
                          ],
                        );
                      },
                    );
                  } else if (state is SignupFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is SignupValidationFailureState) {
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
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("this is papped");
                        if (_formKey.currentState!.validate()) {
                          print("validated");
                          // Only trigger the Signup if the form is valid
                          BlocProvider.of<SignupBloc>(context).add(
                            SignUpUser(
                              email: emailController.text,
                              password: passwordController.text,
                              role:
                                  'Vehicle_Owner', // Ensure this is set correctly
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              confirmPassword: confirmPasswordController.text,
                              address: addressController.text,
                              phoneNo: phoneNumberController.text,
                              dob: '1111-11-11',
                            ),
                          );
                        } else {
                          print("not validated");
                        }
                      },
                      child: Text(
                        state is SignupLoadingState && state.isLoading
                            ? '.......'
                            : 'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Navigation to Login screen
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (route) => false, // This removes all previous routes
                    );
                    // Handle navigation to login
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
