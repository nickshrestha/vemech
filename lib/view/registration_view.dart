import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/signup/signup_bloc.dart';
import 'package:vemech/view/login_view.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(11, (index) => TextEditingController());
  final List<String> _roles = ['Vehicle_Owner', 'Workshop'];
  String? _selectedRole;
  String? _selectedVehicleType; // Variable to hold the selected vehicle type
  final List<String> _vehicleTypes = ['Bikes', 'Cars']; // Vehicle types

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: keyboardType,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: _controllers[0], // firstNameController
                      labelText: 'First Name',
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your first name'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFormField(
                      controller: _controllers[1], // lastNameController
                      labelText: 'Last Name',
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your phone number'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) {
                  // Handle side effects or other actions here if needed.
                },
                builder: (context, state) {
                  return _buildTextFormField(
                    controller: _controllers[2], // usernameController
                    labelText: 'Username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      } else if (state is UserSuccessState &&
                          state.userList.usernames.contains(value)) {
                        return 'Username already taken, please choose another one';
                      }
                      return null; // No error condition met, input is valid.
                    },
                  );

                  // TextFormField(
                  //   controller: usernameController,
                  //   decoration: const InputDecoration(labelText: 'Username'),
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter a username';
                  //     } else if (state is UserSuccessState && state.userList.usernames.contains(value)) {
                  //       return 'Username already taken, please choose another one';
                  //     }
                  //     return null; // No error condition met, input is valid.
                  //   },
                  // );
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                onChanged: (newValue) =>
                    setState(() => _selectedRole = newValue),
                items: _roles
                    .map((role) =>
                        DropdownMenuItem(value: role, child: Text(role)))
                    .toList(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                validator: (value) =>
                    value == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 16),
              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state is EmailSuccessState) {
                    print("this is email: ${state.emailList.emails}");
                  }
                },
                builder: (context, state) {
                  return _buildTextFormField(
                    controller: _controllers[3], // emailController
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        // Here you might want to use more robust email validation
                        return 'Please enter a valid email';
                      }

                      // Optional: Handle additional validation based on bloc state
                      else if (state is EmailSuccessState &&
                          state.emailList.emails.contains(value)) {
                        return 'This email is already in use, please choose another one';
                      }

                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller:
                          TextEditingController(text: '+977'), // Country code
                      readOnly: true,
                      decoration: const InputDecoration(
                          labelText: 'Country Code',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFormField(
                      controller: _controllers[4], // phoneNumberController
                      labelText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your phone number'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _controllers[5], // passwordController
                labelText: 'Password',
                obscureText: true,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter your password'
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _controllers[6], // confirmPasswordController
                labelText: 'Confirm Password',
                obscureText: true,
                validator: (value) => value != _controllers[5].text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _controllers[7], // addressController
                labelText: 'Address',
                validator: (value) =>
                    value!.isEmpty ?? true ? 'Please enter your address' : null,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _controllers[8], // dobController
                labelText: 'Date of Birth (YYYY-MM-DD)',
                keyboardType: TextInputType.numberWithOptions(signed: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  } else if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                    return 'Date has wrong format. Use YYYY-MM-DD';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_selectedRole == "Workshop")
                Column(
                  children: [
                    _buildTextFormField(
                      controller: _controllers[9], // workshopNameController
                      labelText: 'Workshop Name',
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your workshop name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedVehicleType,
                      onChanged: (newValue) =>
                          setState(() => _selectedVehicleType = newValue),
                      items: _vehicleTypes
                          .map((type) =>
                              DropdownMenuItem(value: type, child: Text(type)))
                          .toList(),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      validator: (value) =>
                          value == null ? 'Please select a vehicle type' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: _controllers[10], // panNumberController
                      labelText: 'PAN Number',
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your PAN number'
                          : null,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Expanded(
                      child: Text('I agree to the terms and policy')),
                ],
              ),
              const SizedBox(height: 16),
              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) =>
                    _handleStateChanges(context, state),
                builder: (context, state) => ElevatedButton(
                  onPressed: _handleFormSubmission,
                  child: Text(
                      state is SignupLoadingState && state.isLoading
                          ? 'Loading...'
                          : 'Sign Up',
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                      ModalRoute.withName('/')),
                  child: const Text('Already have an account? Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, SignupState state) {
    if (state is SignupSuccessState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(state.message),
          actions: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.done))
          ],
        ),
      );
    } else if (state is SignupFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.errorMessage), backgroundColor: Colors.red));
    }
  }

  void _handleFormSubmission() {
    if (_formKey.currentState!.validate()) {
      print(
          "this is sign up value ${(_selectedRole == "Workshop") ? true : false}");
      BlocProvider.of<SignupBloc>(context).add(
        (_selectedRole == "Workshop")
            ? SignUpUser(
                email: _controllers[3].text,
                password: _controllers[5].text,
                firstName: _controllers[0].text,
                lastName: _controllers[1].text,
                phoneNo: _controllers[4].text,
                address: _controllers[7].text,
                dob: _controllers[8].text,
                role: _selectedRole!,
                confirmPassword: _controllers[6].text,
                workshopname: _controllers[9].text,
                catagory: _selectedVehicleType,
                panNo: _controllers[10].text, username: _controllers[2].text,
              )
            : SignUpUser(
                email: _controllers[3].text,
                password: _controllers[5].text,
                firstName: _controllers[0].text,
                lastName: _controllers[1].text,
                phoneNo: _controllers[4].text,
                address: _controllers[7].text,
                dob: _controllers[8].text,
                role: _selectedRole!,
                confirmPassword: _controllers[6].text,
                username: _controllers[2].text,
              ),
      );
    }
  }
}
