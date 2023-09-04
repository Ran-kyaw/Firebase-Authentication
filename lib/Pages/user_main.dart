import 'package:firebase_authentication/User/change_pass.dart';
import 'package:firebase_authentication/User/dashboard.dart';
import 'package:firebase_authentication/User/profile.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int selectedIndex = 0;

  //For Route
  static List<Widget> widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    Changepass()
  ];

  //
  void _onItemTappd(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Change Password'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTappd,
      ),
    );
  }
}
