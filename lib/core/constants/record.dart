enum RecordType {
  // Income
  salary,
  bonus,
  investment,
  rent,
  freelance,
  interest,
  otherIncome,

  // Expense
  shopping,
  dining,
  transport,
  travel,
  utilities,
  healthcare,
  education,
  entertainment,
  insurance,
  gifts,
  subscriptions,
  charity,
  rentExpense,
  taxes,
  otherExpenses,
}

extension RecordTypeExtension on RecordType {
  bool get isIncome {
    switch (this) {
      case RecordType.salary:
      case RecordType.bonus:
      case RecordType.investment:
      case RecordType.rent:
      case RecordType.freelance:
      case RecordType.interest:
      case RecordType.otherIncome:
        return true;
      default:
        return false;
    }
  }

  bool get isExpense {
    return !isIncome;
  }
}
