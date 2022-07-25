import 'package:flutter/material.dart';
import 'package:travelmap/gouser/godashboard.dart';
import 'package:travelmap/gouser/goprofile.dart';

class GoUserMain extends StatefulWidget {

  const GoUserMain({Key? key}) : super(key: key);
  @override
  _GoUserMainState createState() => _GoUserMainState();
}

class _GoUserMainState extends State<GoUserMain> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    GoDashBoard(title: 'Travel Map',),
    GoProfile(),
    //ChangePass(),
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;

    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',),
          //BottomNavigationBarItem(
           //icon: Icon(Icons.settings),
            //label: 'Change Password',),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}