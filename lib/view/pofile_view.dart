import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/login/login_bloc.dart';
import 'package:vemech/bloc/profile/profile_bloc.dart';
import 'package:vemech/view/login_view.dart';
import 'package:vemech/models/profile_model.dart'; // Your ProfileModel import

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is! ProfileSucccessState || profileState.profile == null) {
      BlocProvider.of<ProfileBloc>(context).add(UserProfile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            // Handle any side effects or other actions here if needed.
          },
          builder: (context, state) {
            if (state is ProfileLoadingState && state.isLoading) {
        return const CircularProgressIndicator(); // Show a loading indicator
            } else
        
            if (state is ProfileFailureState) {
        return Center(
          child: Text(
            state.errorMessage,
            style: const TextStyle(color: Colors.red),
          ), // Show an error message if fetching profile fails
        );
            } else 
        
            if (state is ProfileSucccessState ) {
        // Successfully fetched the profile
        ProfileModel profile = state.profile; // Get the profile data
        
        return Column(
          children: [
            // Display profile picture
            // CircleAvatar(
            //   radius: 50.0,
            //   backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
            // ),
            const SizedBox(height: 20),
            Text(profile.profileData.user.username, style: const TextStyle(fontSize: 20)),
            Text("${profile.profileData.user.firstName} ${profile.profileData.user.lastName}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Email: ${profile.profileData.user.email}'),
            const SizedBox(height: 10),
            Text('${profile.profileData.phoneNo}'),
            const SizedBox(height: 10),
            Text('${profile.profileData.address}'),
            const SizedBox(height: 10),
            Text('Category: ${profile.profileData.category}'),
            const SizedBox(height: 10),
            Text('${profile.profileData.role}'),
            const SizedBox(height: 10),
            Text('${profile.profileData.workshopName}'),
            const SizedBox(height: 20),
          ],
        );
            }
        
            return const Center(child: Text("No profile data available"));
          },
        ),
        
            const Divider(),
            ListTile(
              title: const Text('Edit Profile', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Handle edit profile
              },
            ),
            ListTile(
              title: const Text('Update Vehicle Info', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Handle update vehicle info
              },
            ),
            ListTile(
              title: const Text('Display Vehicle Info', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Handle display vehicle info
              },
            ),
            ListTile(
              title: const Text('History', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Handle history action
              },
            ),
            ListTile(
              title: const Text('Account Settings', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Handle account settings
              },
            ),
            ListTile(
              title: const Text('Change password', style: TextStyle(fontSize: 18)),
              onTap: () {
                // Handle change password
              },
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLoggedOutState) {
                  print("User logged out, navigating to LoginView.");
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (Route<dynamic> route) => false, // Remove all routes
                  );
                }
              },
              builder: (context, state) {
                return ListTile(
                  onTap: () {
                    print("Logout button tapped.");
        
                    // Show the confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Logout'),
                          content: const Text('Are you sure you want to logout?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Close the dialog without doing anything (Cancel)
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Close the dialog first
                                Navigator.of(context).pop();
        
                                // Trigger the logout event to log the user out
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LogOutUser());
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: const Text('Logout', style: TextStyle(fontSize: 18)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
