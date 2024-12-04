import 'package:flutter/material.dart';
import 'package:vemech/view/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(height: 20),
          const Text('Username', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          const Text('Email: user@example.com'),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Edit Profile', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle edit profile
            },
          ),
          ListTile(
            title: const Text('Update Vehicle Info',
                style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle account settings
            },
          ),
          ListTile(
            title: const Text('Display Vehicle Info',
                style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle account settings
            },
          ),
          ListTile(
            title: const Text('History', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle account settings
            },
          ),
          ListTile(
            title:
                const Text('Account Settings', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle account settings
            },
          ),
          ListTile(
            title:
                const Text('Change password', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle logout
            },
          ),
          ListTile(
            title: const Text('Logout', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginView()),
                (Route<dynamic> route) => false,
              );
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}
