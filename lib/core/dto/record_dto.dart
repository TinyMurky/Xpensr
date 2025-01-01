import 'package:xpensr/core/constants/currency.dart';
import 'package:xpensr/core/constants/record.dart';

class RecordDto {
  /// The transaction amount in foreign currency
  double _amount;

  int? id;

  /// the currency used fot the transaction (Ex: usd)
  final CurrencyType currency;

  /// The extrange rate on the transaction date, currency to systemBaseCurrency
  final double exchangeRate;

  /// Currency that system force to store
  final CurrencyType systemBaseCurrency;

  final RecordType type;

  /// Title that display on listtile title
  final String title;

  DateTime? createdAt;

  DateTime? updatedAt;

  DateTime? deletedAt;

  RecordDto({
    required double amount,
    required this.currency,
    required this.exchangeRate,
    required this.systemBaseCurrency,
    required this.type,
    required this.title,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  }) : _amount = amount.abs();

  /// systemBaseCurrency set to tw
  RecordDto.withSystemCurrency({
    required double amount,
    required this.currency,
    required this.exchangeRate,
    required this.type,
    required this.title,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  })  : _amount = amount.abs(),
        systemBaseCurrency = CurrencyType.twd;

  RecordDto.twd({
    required double amount,
    required this.type,
    required this.title,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  })  : _amount = amount.abs(),
        currency = CurrencyType.twd,
        exchangeRate = 1.0,
        systemBaseCurrency = CurrencyType.twd;

  // Transform map from sqflite to RecordDto
  factory RecordDto.fromMap(Map<String, Object?> map) {
    int? columnId = map["id"] as int?;
    String columnTitle = map["title"] as String;
    double columnAmount = map["amount"] as double;
    CurrencyType columnCurrency = CurrencyType.values.firstWhere(
      (CurrencyType element) => element.toString() == map["currency"],
      orElse: () => CurrencyType.twd,
    );
    double columnExchangeRate = map["exchange_rate"] as double;
    CurrencyType columnSystemBaseCurrency = CurrencyType.values.firstWhere(
      (CurrencyType element) => element.toString() == map["system_base_curren"],
      orElse: () => CurrencyType.twd,
    );
    RecordType columnType = RecordType.values.firstWhere(
      (RecordType element) => element.toString() == map["Type"],
      orElse: () => RecordType.otherExpenses,
    );

    DateTime columnCreatedAt = DateTime.parse(map["created_at"] as String);
    DateTime columnUpdatedAt = DateTime.parse(map["updated_at"] as String);

    String? columnDeletedAtString =
        map["deleted_at"] != null ? map["deleted_at"] as String : null;
    DateTime? columnDeletedAt = columnDeletedAtString != null
        ? DateTime.parse(columnDeletedAtString)
        : null;

    return RecordDto(
      id: columnId,
      title: columnTitle,
      amount: columnAmount,
      currency: columnCurrency,
      exchangeRate: columnExchangeRate,
      systemBaseCurrency: columnSystemBaseCurrency,
      type: columnType,
      createdAt: columnCreatedAt,
      updatedAt: columnUpdatedAt,
      deletedAt: columnDeletedAt,
    );
  }

  /// Transfer dto to shape that can be saved into dao
  Map<String, Object?> toMap({
    bool? excludeUpdatedAt,
  }) {
    var map = <String, Object?>{
      "title": title,
      "amount": _amount,
      "currency": currency.toString(),
      "exchange_rate": exchangeRate,
      "system_base_currency": systemBaseCurrency.toString(),
      "type": type.toString(),
    };

    if (id != null) {
      map["id"] = id;
    }

    if (createdAt != null) {
      map["created_at"] = createdAt?.toIso8601String();
    }

    if (updatedAt != null && (excludeUpdatedAt == null || !excludeUpdatedAt)) {
      map["updated_at"] = updatedAt?.toIso8601String();
    }

    if (deletedAt != null) {
      map["deleted_at"] = deletedAt?.toIso8601String();
    }
    return map;
  }

  double get amount {
    final int sign = type.isIncome ? 1 : -1;
    return _amount * sign;
  }

  /// Always Store non0negative number
  set amount(double input) {
    _amount = input.abs();
  }

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
    final String localAmountString = localAmount.abs().toStringAsFixed(2);
    final String display = '$minusSign\$$localAmountString';
    return display;
  }
}
