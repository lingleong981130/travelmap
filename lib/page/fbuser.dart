import 'package:flutter/material.dart';
import 'package:travelmap/fbuser/fbdashboard.dart';
import 'package:travelmap/fbuser/fbprofile.dart';




class FbUserMain extends StatefulWidget {

  const FbUserMain({Key? key}) : super(key: key);
  @override
  _FbUserMainState createState() => _FbUserMainState();
}

class _FbUserMainState extends State<FbUserMain> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FbDashBoard(title: 'Travel Map',),
    FbProfile(),
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