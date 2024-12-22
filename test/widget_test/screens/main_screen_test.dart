// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xpensr/screens/book_keeping_screen.dart';
import 'package:xpensr/screens/chart_screen.dart';
import 'package:xpensr/screens/main_screen.dart';

void main() {
  group('MainScreen Widget Test', () {
    testWidgets('MainScreen contains bottomNavigationBar',
        (WidgetTester tester) async {
      // Scaffold need to be put inside material app
      await tester.pumpWidget(
        MaterialApp(
          home: const MainScreen(),
        ),
      );

      // Verify that BottomNavigatorBar Exist.
      final bottomNavigatorBar = find.byType(BottomNavigationBar);
      expect(bottomNavigatorBar, findsOneWidget);

      // Verify that their is at least two button
      // (Not Recommand, item is inside BottomNavigationBar, test can't find it)
      // final bottomNavigationBarItem = find.byType(BottomNavigationBarItem);
      // expect(bottomNavigationBarItem, findsNWidgets(2));

      // check if  BottomNavigationBarItem Exist
      expect(find.byIcon(Icons.calculate), findsOneWidget);
      expect(find.byIcon(Icons.bar_chart), findsOneWidget);

      // 驗證初始頁面是否為 BookKeepingScreen
      // expect(find.byType(BookKeepingScreen), findsOneWidget);
      // expect(find.byType(ChartScreen), findsNothing);
    });

    testWidgets('Tapping BottomNavigationBar item switches pages', (
      WidgetTester tester,
    ) async {
      // Scaffold need to be put inside material app
      await tester.pumpWidget(
        MaterialApp(
          home: const MainScreen(),
        ),
      );

      // Test if first page is BookKeepingScreen
      expect(find.byType(BookKeepingScreen), findsOneWidget);
      expect(find.byType(ChartScreen), findsNothing);

      // tap chart icon
      await tester.tap(find.byIcon(Icons.bar_chart));
      await tester.pumpAndSettle();


      // Test if page is ChartScreen after tap
      expect(find.byType(BookKeepingScreen), findsNothing);
      expect(find.byType(ChartScreen), findsOneWidget);


      // tap calculate icon
      await tester.tap(find.byIcon(Icons.calculate));
      await tester.pumpAndSettle();

      // Test if BookKeepingScreen is display after tab calculate
      expect(find.byType(BookKeepingScreen), findsOneWidget);
      expect(find.byType(ChartScreen), findsNothing);
    });
  });
}
