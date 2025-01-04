import 'package:flutter_test/flutter_test.dart';

import 'package:xpensr/core/constants/currency.dart';
import 'package:xpensr/core/constants/record.dart';
import 'package:xpensr/core/dto/record_dto.dart';

void main() {
  group('Test RecordDto init', () {
    test('the "currency" init by withSystemCurrency is twd', () {
      final recordDto = RecordDto.withSystemCurrency(
          amount: 1.0,
          currency: CurrencyType.usd,
          exchangeRate: 32.0,
          type: RecordType.interest,
          title: 'test',
          date: DateTime(2025, 1, 1),
      );
      expect(recordDto.systemBaseCurrency, CurrencyType.twd);
    });
  });

  group('Test RecordDto getter, setter', () {
    setUp(() {
    });

    tearDown((){});

    test('amount will be negative when is Expense', () {
      final recordDto = RecordDto.withSystemCurrency(
          amount: 1.0,
          currency: CurrencyType.usd,
          exchangeRate: 32.0,
          type: RecordType.shopping, // Expense
          title: 'test',
          date: DateTime(2025, 1, 1),
      );

      expect(recordDto.amount, -1);
    });


    test('localAmount will be negative and multi when is Expense', () {
      final recordDto = RecordDto.withSystemCurrency(
          amount: 1.0,
          currency: CurrencyType.usd,
          exchangeRate: 32.0,
          type: RecordType.shopping, // Expense
          title: 'test',
          date: DateTime(2025, 1, 1),
      );

      expect(recordDto.localAmount, -32);
    });

    test('_amiunt will be store with abs ', () {
      final recordDto = RecordDto.withSystemCurrency(
          amount: 1.0,
          currency: CurrencyType.usd,
          exchangeRate: 32.0,
          type: RecordType.bonus, // Income
          date: DateTime(2025, 1, 1),
          title: 'test',
      );

      recordDto.amount = -5;

      expect(recordDto.amount, 5);
    });
  });
}
