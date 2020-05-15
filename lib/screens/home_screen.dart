import 'package:flutter/material.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/screens/main/main_navigator.dart';

enum HomeTab { main, assistant, profile }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final mainNavigatorKey = GlobalKey<NavigatorState>();

  var currentTab = HomeTab.main;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Offstage(
              child: MainNavigator(mainNavigatorKey),
              offstage: currentTab != HomeTab.main,
            ),
            Offstage(
              child: Container(color: Colors.white),
              offstage: currentTab != HomeTab.assistant,
            ),
            Offstage(
              child: Container(color: Colors.white),
              offstage: currentTab != HomeTab.profile,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab.index,
          selectedItemColor: GreenhousesColors.green,
          selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Graphik', fontWeight: FontWeight.w600, color: GreenhousesColors.green),
          unselectedItemColor: GreenhousesColors.gray,
          unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'Graphik', fontWeight: FontWeight.w400, color: GreenhousesColors.grayText),
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              currentTab = HomeTab.values[index];
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
      ),
    );
  }

  Future<bool> _onWillPop() async {
    switch(currentTab) {
      case HomeTab.main:
        return !await mainNavigatorKey.currentState.maybePop();
      default:
        return false;
    }
  }
}
