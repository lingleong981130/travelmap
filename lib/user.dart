import 'package:flutter/material.dart';
import 'package:travelmap/user/change_pass.dart';
import 'package:travelmap/user/dashboard.dart';
import 'package:travelmap/user/profile.dart';


class UserMain extends StatefulWidget {
  const UserMain({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Profile(),
    ChangePass(),
    //Favorite(),
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;

    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Change Password',),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}