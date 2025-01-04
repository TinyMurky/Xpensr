import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xpensr/core/constants/colors.dart';

import 'package:xpensr/core/constants/currency.dart';
import 'package:xpensr/core/constants/record.dart';
import 'package:xpensr/core/dto/record_dto.dart';
import 'package:xpensr/widgets/record_card.dart';
import 'package:xpensr/widgets/styles/record_type_style.dart';

void main() {
  group('Test RecordCard', () {
    testWidgets('RecordCard Render Correctly', (WidgetTester tester) async {
      final recordDto = RecordDto.withSystemCurrency(
        amount: 1.0,
        currency: CurrencyType.usd,
        exchangeRate: 32.0,
        type: RecordType.interest,
        date: DateTime(2025, 1, 1),
        title: 'test title',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RecordCard(recordDto: recordDto),
        ),
      );

      final RecordTypeStyle recordTypeStyle =
          RecordTypeStyle.getStyle(RecordType.interest);

      final testTitle = find.text('test title');
      expect(testTitle, findsOneWidget);

      final testSubtitle = find.text(recordTypeStyle.displayedName);
      expect(testSubtitle, findsOneWidget);

      final testIcon = find.byIcon(recordTypeStyle.icon);
      expect(testIcon, findsOneWidget);

      final testAmount = find.text(recordDto.toLocalAmountString());
      expect(testAmount, findsOneWidget);
    });
    
    testWidgets('RecordCard Icon Change Color when', (WidgetTester tester) async {
      final recordDto = RecordDto.withSystemCurrency(
        amount: 1.0,
        currency: CurrencyType.usd,
        exchangeRate: 32.0,
        type: RecordType.interest,
        date: DateTime(2025, 1, 1),
        title: 'test title',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RecordCard(recordDto: recordDto),
        ),
      );


      final RecordTypeStyle recordTypeStyle =
          RecordTypeStyle.getStyle(RecordType.interest);

      final testIconFinder = find.byIcon(recordTypeStyle.icon);
      expect(testIconFinder, findsOneWidget); // use finder

      // use widget to test attribute of widget
      Icon testIcon = tester.widget<Icon>(testIconFinder);
      expect((testIcon).color, recordTypeStyle.color);

      await tester.tap(testIconFinder);
      await tester.pump();
      // Need to be replaced by new tabed widget in widget tree
      testIcon = tester.widget<Icon>(testIconFinder);
      expect((testIcon).color, rhoneBlue);

      await tester.tap(testIconFinder);
      await tester.pumpAndSettle();
      testIcon = tester.widget<Icon>(testIconFinder);
      expect((testIcon).color, recordTypeStyle.color);
    });
  });
}
