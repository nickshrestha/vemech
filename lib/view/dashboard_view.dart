import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vemech/bloc/home/home_bloc.dart';
import 'package:vemech/bloc/profile/profile_bloc.dart';
import 'package:vemech/view/home_view.dart';
import 'package:vemech/view/onsite_view.dart';
import 'package:vemech/view/profile_view.dart';

// Main dashboard view which holds different sections of the app
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // Current index of the selected item on the bottom navigation bar
  int _selectedIndex = 0;

  // List of widget pages to display based on the selected index
  static const List<Widget> _pages = <Widget>[
    HomePageView(),
    Center(
        child: Text('Workshop',
            style: TextStyle(fontSize: 24))), // Placeholder for Workshop view
    Center(
        child: Text('Appointment',
            style:
                TextStyle(fontSize: 24))), // Placeholder for Appointment view
    OnSite(),
    ProfileView(), // Actual ProfileView widget, not just a placeholder
  ];

  // Function to handle item taps on the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the index to show the selected page
    });
  }
  
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(UserHome());
     BlocProvider.of<ProfileBloc>(context).add(UserProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Removes the default back button on the AppBar
        backgroundColor:
            Colors.green, // Sets the background color of the AppBar
        centerTitle: true,
        title: const Text('Vemech',
            textAlign: TextAlign.center), // AppBar title centered
      ),
      body: _pages[
          _selectedIndex], // Display the selected page based on the current index
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Workshop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: 'Onsite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Current selected index
        backgroundColor:
            Colors.green, // Explicitly setting the background to green
        selectedItemColor: Colors.green, // Color of the selected item
        unselectedItemColor: Colors
            .grey, // Lighter white for unselected items, for better contrast
        onTap: _onItemTapped, // Function to handle tapping on items
      ),
    );
  }
}
