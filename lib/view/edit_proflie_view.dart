import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:vemech/bloc/profile/profile_bloc.dart';


class EditProfleForm extends StatefulWidget {
  const EditProfleForm({super.key});

  @override
  _EditProfleFormState createState() => _EditProfleFormState();
}

class _EditProfleFormState extends State<EditProfleForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());

  String? _selectedVehicleType; // Variable to hold the selected vehicle type
  final List<String> _vehicleTypes = ['Bikes', 'Cars']; // Vehicle types
  String? _role;

  @override
  void initState() {
    var bloc = context.read<ProfileBloc>().state;
    if (bloc is ProfileSucccessState) {
      _controllers[0].text = bloc.profile.profileData.phoneNo.toString();
      _controllers[1].text = bloc.profile.profileData.address.toString();
      // _controllers[2].text = DateFormat('yyyy-MM-dd')
      //     .format(bloc.profile.profileData.dob!)
      //     .toString();
      if (bloc.profile.profileData.role == "Workshop") {
        _selectedVehicleType = bloc.profile.profileData.category.toString();

        _controllers[3].text = bloc.profile.profileData.workshopName.toString();
        _controllers[4].text = bloc.profile.profileData.panNo.toString();
      }
      _role = bloc.profile.profileData.role;
    }
    super.initState();
  }

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Expanded(
                  child: _buildTextFormField(
                    controller: _controllers[0], // phoneNumberController
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your phone number'
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _controllers[1], // addressController
                  labelText: 'Address',
                  validator: (value) => value!.isEmpty ?? true
                      ? 'Please enter your address'
                      : null,
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _controllers[2], // dobController
                  labelText: 'Date of Birth (YYYY-MM-DD)',
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    } else if (!RegExp(r'^\d{4}-\d{2}-\d{2}$')
                        .hasMatch(value)) {
                      return 'Date has wrong format. Use YYYY-MM-DD';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (state is ProfileSucccessState &&
                    state.profile.profileData.role == "Workshop")
                  Column(
                    children: [
                      _buildTextFormField(
                        controller: _controllers[3], // workshopNameController
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
                            .map((type) => DropdownMenuItem(
                                value: type, child: Text(type)))
                            .toList(),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                        validator: (value) => value == null
                            ? 'Please select a vehicle type'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        controller: _controllers[4], // workshopNameController
                        labelText: 'Pan Number',
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter your Pan Number'
                            : null,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                BlocConsumer<EditProfileBloc, EditProfileState>(
                  listener: (context, state) =>
                      _handleStateChanges(context, state),
                  builder: (context, state) => ElevatedButton(
                    onPressed: _handleFormSubmission,
                    child: Text(
                        state is EditProfileLoadingState && state.isLoading
                            ? 'Loading...'
                            : 'Edit Profile',
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _handleStateChanges(BuildContext context, EditProfileState state) {
    if (state is EditProfileSucccessState) {
      BlocProvider.of<ProfileBloc>(context).add(UserProfile());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(state.successMessage),
          actions: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.done))
          ],
        ),
      );
    } else if (state is EditProfileFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.errorMessage), backgroundColor: Colors.red));
    }
  }

  void _handleFormSubmission() {
    if (_formKey.currentState!.validate()) {
      print("safjbflasnfln this hello");
      // print(
      //     "this is sign up value ${(_selectedRole == "Workshop") ? true : false}");
      BlocProvider.of<EditProfileBloc>(context).add(
        (_role == "Workshop")
            ? EditUserProfile(
              role: "Workshop",
                workshopname: _controllers[3].text,
                catagory: _selectedVehicleType,
                // panNo: _controllers[4].text,
              )
            : EditUserProfile(
             
                phoneNo: _controllers[0].text,
                address: _controllers[1].text,
                dob: _controllers[2].text,
              ),
      );
    }
  }
}
