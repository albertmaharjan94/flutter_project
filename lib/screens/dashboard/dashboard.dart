import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_baz/screens/account/account_screen.dart';
import 'package:n_baz/screens/home/home_screen.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  PageController pageController = PageController();
  int selectedIndex = 0;
  _onPageChanged(int index) {
    // onTap
    setState(() {
      selectedIndex = index;

    });
  }

  _itemTapped(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
    setState(() {
      this.selectedIndex = selectedIndex;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: <Widget>[HomeScreen(), Container(), AccountScreen()],
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        onTap: _itemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:"Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label:"Favorite"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label:"Account"
          ),
        ],
      ),
    );
  }
}
