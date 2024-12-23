import 'package:xpensr/core/constants/currency.dart';

class RecordDto {
  /// The transaction amount in foreign currency
  final double amount;

  /// the currency used fot the transaction (Ex: usd)
  final CurrencyType currency;

  /// The extrange rate on the transaction date, currency to systemBaseCurrency
  final double exchangeRate;

  /// Currency that system force to store
  final CurrencyType systemBaseCurrency;

  RecordDto({
    required this.amount,
    required this.currency,
    required this.exchangeRate,
  }) : systemBaseCurrency = CurrencyType.twd;

  /// The converted amount from currency to base currency
  double get localAmount {
    return amount * exchangeRate;
  }

  /// [userExchangeRate]: The exchange from [Currency] to the currency user want
  double getAmmountInUserCurrency(double userExchangeRate) {
    return amount * userExchangeRate;
  }
}
