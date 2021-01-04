import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Screens/advancedSearch.dart';
import 'package:rate_my_tutor/Screens/homePage.dart';

class BottomNavBar extends StatefulWidget {
  static String bottomNavBarID = "bottomNavBar";
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    HomePage(), AdvancedSearch()
  ];

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  int _selectedIndex = 0;
  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home,
               // color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
             // color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
            label: "Advanced Search",
          ),
        ],

        selectedItemColor: _selectedIndex == 0 ? Colors.blue : Colors.grey,
        unselectedItemColor: _selectedIndex == 1 ? Colors.blue:Colors.grey,

      ),
    );
  }
}
