import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:provider/provider.dart';

import '../stm/theme_provider.dart';
import 'tester.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content goes here
          goToScreen(_selectedIndex),
          // Positioned Bottom Navigation Bar on top
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.transparent
                    .withOpacity(.7), // Transparent background
                border: const Border(
                  top: BorderSide(
                    color: Colors.white, // White border at the top
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    iconSize: 34,
                    color: _selectedIndex == 0
                        ? ApplicationColors.e00
                        : Colors.grey,
                    onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 34,
                    color: _selectedIndex == 1
                        ? ApplicationColors.e00
                        : Colors.grey,
                    onPressed: () => _onItemTapped(1),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    iconSize: 34,
                    color: _selectedIndex == 2
                        ? ApplicationColors.e00
                        : Colors.grey,
                    onPressed: () => _onItemTapped(2),
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    iconSize: 34,
                    color: _selectedIndex == 3
                        ? ApplicationColors.e00
                        : Colors.grey,
                    onPressed: () => _onItemTapped(3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
    goToScreen(_selectedIndex);
  }

  goToScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const CustomScreen();
      case 1:
        return const Center(
          child: Text("Second Screen"),
        );
      case 2:
        return const Center(
          child: Text("Third Screen"),
        );
      case 3:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ThemeStateProvider>().setDarkTheme();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      right: 12, top: 12, bottom: 12, left: 8),
                  child: ApplicationUtils.isDarkTheme(context)
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.light_mode_outlined),
                ),
              )
            ],
          ),
        );
    }
  }
}
