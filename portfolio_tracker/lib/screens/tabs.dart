import 'package:flutter/material.dart';
import 'package:portfolio_tracker/screens/dashboard.dart';
import 'package:portfolio_tracker/screens/portfolio.dart';
import 'package:portfolio_tracker/screens/search.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
    required this.token,
  });
  final String token;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void onSelectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = DashboardScreen(
      token: widget.token,
    );

    if (_selectedIndex == 1) {
      activeScreen = SearchScreen(
        token: widget.token,
      );
    }
    else if(_selectedIndex == 2)
    {
      activeScreen = PortfolioScreen();
    }
    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Portfolio',
            icon: Icon(
              Icons.shopping_bag,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onSelectPage,
      ),
    );
  }
}
