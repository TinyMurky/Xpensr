// Reference:
// https://juejin.cn/post/6973534234233274404
// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

import 'package:flutter/material.dart';

import 'package:xpensr/core/constants/screen.dart';
import 'package:xpensr/screens/book_keeping_screen.dart';
import 'package:xpensr/screens/chart_screen.dart';

/// This is the Navigation Bar page
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  ScreenEnums _currentScreen = ScreenEnums.bookKeeping;

  /// The pages that will be present when _currentScreen is changed
  /// use `late` because I don't want it to be rebuild every time screen been changed
  /// init in initState()
  late List<Widget> screensWillBeDisplayed;

  /// When Button is pressed, change current screen enum
  void _changeScreenByIndex(int index) {
    final ScreenEnums nextScreen = ScreenEnumsExtension.fromIndex(index);

    setState(() {
      _currentScreen = nextScreen;
    });
  }

  @override
  void initState() {
    super.initState();

    screensWillBeDisplayed = [
      BookKeepingScreen(),
      ChartScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentScreen.toIndex,
        children: screensWillBeDisplayed,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen.toIndex,
        onTap: _changeScreenByIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'Book Keepeing'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Chart'),
        ],
      ),
    );
  }
}
