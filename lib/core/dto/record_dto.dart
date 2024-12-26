import 'package:xpensr/core/constants/currency.dart';
import 'package:xpensr/core/constants/record.dart';

class RecordDto {
  /// The transaction amount in foreign currency
  final double amount;

  /// the currency used fot the transaction (Ex: usd)
  final CurrencyType currency;

  /// The extrange rate on the transaction date, currency to systemBaseCurrency
  final double exchangeRate;

  /// Currency that system force to store
  final CurrencyType systemBaseCurrency;

  final RecordType type;

  /// Title that display on listtile title
  final String title;

  RecordDto(
      {
      required this.amount,
      required this.currency,
      required this.exchangeRate,
      required this.systemBaseCurrency,
      required this.type,
      required this.title,
  });

  /// systemBaseCurrency set to tw
  RecordDto.withSystemCurrency({
    required this.amount,
    required this.currency,
    required this.exchangeRate,
    required this.type,
    required this.title,
  }) : systemBaseCurrency = CurrencyType.twd;

  RecordDto.twd({
    required this.amount,
    required this.type,
    required this.title,
  })  : currency = CurrencyType.twd,
        exchangeRate = 1.0,
        systemBaseCurrency = CurrencyType.twd;

  /// The converted amount from currency to base currency
  double get localAmount {
    return amount * exchangeRate;
  }

  /// [userExchangeRate]: The exchange from [Currency] to the currency user want
  double getAmmountInUserCurrency(double userExchangeRate) {
    return amount * userExchangeRate;
  }

  String toLocalAmountString() {
    final isNegative = localAmount < 0;
    final String minusSign = isNegative ? '-' : '';
    final String localAmountString = localAmount.toStringAsFixed(2);
    final String display = '$minusSign\$$localAmountString';
    return display;
  }
}
