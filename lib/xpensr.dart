import 'package:flutter/material.dart';

import 'package:expense_tracker_app/core/utils/gloable_theme_data.dart';
import 'package:expense_tracker_app/screens/main_screen.dart';

class Xpensr extends StatelessWidget{
  const Xpensr({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Xpensr',
      themeMode: ThemeMode.system,
      theme: GloableThemeData.lightThemeData,
      darkTheme: GloableThemeData.darkThemeData,
      home: MainScreen(),
    );
  }
}
