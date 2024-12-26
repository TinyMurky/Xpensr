import 'package:flutter/material.dart';

import 'package:xpensr/core/constants/record.dart';
import 'package:xpensr/core/utils/color.dart';

/// [RecordTypeStyle] Mapping [recordType] to Icons and colors
class RecordTypeStyle {
  final IconData icon;
  final Color color;
  final String displayedName;

  /// Determine how lighten the lightenColor Compare to original color
  final double _lightenColorAdjustDegree = 0.1;

  /// Determine how darken the darkenColor Compare to original color
  final double _darkenColorAdjustDegree = -0.1;

  const RecordTypeStyle({
    required this.icon,
    required this.color,
    required this.displayedName,
  });

  /// Get [ReRecordTypeStyle] By [RecordType]
  static RecordTypeStyle getStyle(RecordType type) {
    final RecordTypeStyle style = styles[type] ??
        RecordTypeStyle(
          icon: Icons.help,
          displayedName: 'Unknown',
          color: Colors.black,
        );

    return style;
  }


  /// Get lighter version of Color
  Color get lightenColor {
    return changeColorLightness(
      color: color,
      amount: _lightenColorAdjustDegree,
    );
  }


  /// Get darken version of Color
  Color get darkColor {
    return changeColorLightness(
      color: color,
      amount: _darkenColorAdjustDegree,
    );
  }



  static const Map<RecordType, RecordTypeStyle> styles = {
    // 收入類型
    RecordType.salary: RecordTypeStyle(
      icon: Icons.attach_money,
      displayedName: 'Salary',
      color: Colors.greenAccent,
    ),
    RecordType.bonus: RecordTypeStyle(
      icon: Icons.card_giftcard,
      displayedName: 'Bonus',
      color: Colors.pinkAccent,
    ),
    RecordType.investment: RecordTypeStyle(
      icon: Icons.trending_up,
      displayedName: 'Investment',
      color: Colors.teal,
    ),
    RecordType.rent: RecordTypeStyle(
      icon: Icons.home,
      displayedName: 'Rent Income',
      color: Colors.blueGrey,
    ),
    RecordType.freelance: RecordTypeStyle(
      icon: Icons.work_outline,
      displayedName: 'Freelance',
      color: Colors.orange,
    ),
    RecordType.interest: RecordTypeStyle(
      icon: Icons.savings,
      displayedName: 'Interest',
      color: Colors.lightBlueAccent,
    ),
    RecordType.otherIncome: RecordTypeStyle(
      icon: Icons.account_balance,
      displayedName: 'Other Income',
      color: Colors.amber,
    ),
    // 支出類型
    RecordType.shopping: RecordTypeStyle(
      icon: Icons.shopping_cart,
      displayedName: 'Shopping',
      color: Colors.redAccent,
    ),
    RecordType.dining: RecordTypeStyle(
      icon: Icons.restaurant,
      displayedName: 'Dining',
      color: Colors.deepOrangeAccent,
    ),
    RecordType.transport: RecordTypeStyle(
      icon: Icons.directions_car,
      displayedName: 'Transport',
      color: Colors.blueAccent,
    ),
    RecordType.travel: RecordTypeStyle(
      icon: Icons.flight,
      displayedName: 'Travel',
      color: Colors.lightBlue,
    ),
    RecordType.utilities: RecordTypeStyle(
      icon: Icons.electrical_services,
      displayedName: 'Utilities',
      color: Colors.purpleAccent,
    ),
    RecordType.healthcare: RecordTypeStyle(
      icon: Icons.local_hospital,
      displayedName: 'Healthcare',
      color: Colors.red,
    ),
    RecordType.education: RecordTypeStyle(
      icon: Icons.school,
      displayedName: 'Education',
      color: Colors.indigo,
    ),
    RecordType.entertainment: RecordTypeStyle(
      icon: Icons.movie,
      displayedName: 'Entertainment',
      color: Colors.pink,
    ),
    RecordType.insurance: RecordTypeStyle(
      icon: Icons.shield,
      displayedName: 'Insurance',
      color: Colors.blueGrey,
    ),
    RecordType.gifts: RecordTypeStyle(
      icon: Icons.card_giftcard,
      displayedName: 'Gifts',
      color: Colors.green,
    ),
    RecordType.subscriptions: RecordTypeStyle(
      icon: Icons.subscriptions,
      displayedName: 'Subscriptions',
      color: Colors.cyan,
    ),
    RecordType.charity: RecordTypeStyle(
      icon: Icons.volunteer_activism,
      displayedName: 'Charity',
      color: Colors.lightGreen,
    ),
    RecordType.rentExpense: RecordTypeStyle(
      icon: Icons.home,
      displayedName: 'Rent Expense',
      color: Colors.brown,
    ),
    RecordType.taxes: RecordTypeStyle(
      icon: Icons.account_balance,
      displayedName: 'Taxes',
      color: Colors.deepPurple,
    ),
    RecordType.otherExpenses: RecordTypeStyle(
      icon: Icons.more_horiz,
      displayedName: 'Other Expenses',
      color: Colors.grey,
    ),
  };
}
