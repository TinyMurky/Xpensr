enum ScreenEnums {
  bookKeeping, // Main Page, the page user can see all Expense, and with input model
  chart, // this page user can read the analysis of their spening
}


/// Encapsulate ScreenEnums with index2Enum and Enum2Index function
extension ScreenEnumsExtension on ScreenEnums {

  /// Get ScreenEnums By input index
  static ScreenEnums fromIndex (int index) => ScreenEnums.values[index];

  /// Return Index directly, Same as ScreenEnums.chart.index
  int get toIndex => index;
}
