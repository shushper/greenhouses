import 'package:flutter/material.dart';
import 'package:greenhouses/colors.dart';
import 'package:greenhouses/greenhouses_icons.dart';
import 'package:greenhouses/main_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            child: MainScreen(),
            offstage: currentPage != 0,
          ),
          Offstage(
            child: Container(color: Colors.lightGreen),
            offstage: currentPage != 1,
          ),
          Offstage(
            child: Container(color: Colors.blueGrey),
            offstage: currentPage != 2,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        selectedItemColor: GreenhousesColors.green,
        selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Graphik', fontWeight: FontWeight.w600, color: GreenhousesColors.green),
        unselectedItemColor: GreenhousesColors.gray,
        unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Graphik', fontWeight: FontWeight.w400, color: GreenhousesColors.gray),
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(GreenhousesIcons.home_tab),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Home'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(GreenhousesIcons.assistant_tab),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Assistant'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(GreenhousesIcons.profile_tab),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Profile'),
            ),
          )
        ],
      ),
    );
  }
}
