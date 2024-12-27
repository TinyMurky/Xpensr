import 'package:flutter/material.dart';

import 'package:xpensr/core/constants/record.dart';
import 'package:xpensr/core/utils/color.dart';

/// [RecordTypeStyle] Mapping [recordType] to Icons and colors
class RecordTypeStyle {
  final IconData icon;
  final Color color;
  final String displayedName;

  /// Determine how lighten the lightenColor Compare to original color
  final double _lightenColorAdjustDegree = 1.4;

  /// Determine how darken the darkenColor Compare to original color
  final double _darkenColorAdjustDegree = 0.4;

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
    return makeColorMorePinky(
      color: color,
      lightenDegree: _lightenColorAdjustDegree,
    );
  }

  /// Get darken version of Color
  Color get darkerColor {
    return makeColorMorePinky(
      color: color,
      lightenDegree: _darkenColorAdjustDegree,
    );
  }

  static const Map<RecordType, RecordTypeStyle> styles = {
    // 收入類型
    RecordType.salary: RecordTypeStyle(
      icon: Icons.attach_money,
      displayedName: 'Salary',
      color: Color.fromARGB(255, 239, 83, 80),
    ),
    RecordType.bonus: RecordTypeStyle(
      icon: Icons.card_giftcard,
      displayedName: 'Bonus',
      color: Color.fromARGB(255, 236, 64, 122),
    ),
    RecordType.investment: RecordTypeStyle(
      icon: Icons.trending_up,
      displayedName: 'Investment',
      color: Color.fromARGB(255, 171, 71, 188),
    ),
    RecordType.rent: RecordTypeStyle(
      icon: Icons.home,
      displayedName: 'Rent Income',
      color: Color.fromARGB(255, 126, 87, 194),
    ),
    RecordType.freelance: RecordTypeStyle(
      icon: Icons.work_outline,
      displayedName: 'Freelance',
      color: Color.fromARGB(255, 92, 107, 192),
    ),
    RecordType.interest: RecordTypeStyle(
      icon: Icons.savings,
      displayedName: 'Interest',
      color: Color.fromARGB(255, 66, 165, 254),
    ),
    RecordType.otherIncome: RecordTypeStyle(
      icon: Icons.account_balance,
      displayedName: 'Other Income',
      color: Color.fromARGB(255, 41, 182, 246),
    ),
    // 支出類型
    RecordType.shopping: RecordTypeStyle(
      icon: Icons.shopping_cart,
      displayedName: 'Shopping',
      color: Color.fromARGB(255, 38, 198, 218),
    ),
    RecordType.dining: RecordTypeStyle(
      icon: Icons.restaurant,
      displayedName: 'Dining',
      color: Color.fromARGB(255, 38, 166, 154),
    ),
    RecordType.transport: RecordTypeStyle(
      icon: Icons.directions_car,
      displayedName: 'Transport',
      color: Color.fromARGB(255, 102, 187, 106),
    ),
    RecordType.travel: RecordTypeStyle(
      icon: Icons.flight,
      displayedName: 'Travel',
      color: Color.fromARGB(255, 156, 204, 101),
    ),
    RecordType.utilities: RecordTypeStyle(
      icon: Icons.electrical_services,
      displayedName: 'Utilities',
      color: Color.fromARGB(255, 212, 225, 87),
    ),
    RecordType.healthcare: RecordTypeStyle(
      icon: Icons.local_hospital,
      displayedName: 'Healthcare',
      color: Color.fromARGB(255, 255, 238, 88),
    ),
    RecordType.education: RecordTypeStyle(
      icon: Icons.school,
      displayedName: 'Education',
      color: Color.fromARGB(255, 255, 202, 40),
    ),
    RecordType.entertainment: RecordTypeStyle(
      icon: Icons.movie,
      displayedName: 'Entertainment',
      color: Color.fromARGB(255, 255, 167, 38),
    ),
    RecordType.insurance: RecordTypeStyle(
      icon: Icons.shield,
      displayedName: 'Insurance',
      color: Color.fromARGB(255, 255, 112, 67),
    ),
    RecordType.gifts: RecordTypeStyle(
      icon: Icons.card_giftcard,
      displayedName: 'Gifts',
      color: Color.fromARGB(255, 229, 115, 115),
    ),
    RecordType.subscriptions: RecordTypeStyle(
      icon: Icons.subscriptions,
      displayedName: 'Subscriptions',
      color: Color.fromARGB(255, 240, 98, 146),
    ),
    RecordType.charity: RecordTypeStyle(
      icon: Icons.volunteer_activism,
      displayedName: 'Charity',
      color: Color.fromARGB(255, 186, 104, 200),
    ),
    RecordType.rentExpense: RecordTypeStyle(
      icon: Icons.home,
      displayedName: 'Rent Expense',
      color: Color.fromARGB(255, 149, 117, 205),
    ),
    RecordType.taxes: RecordTypeStyle(
      icon: Icons.account_balance,
      displayedName: 'Taxes',
      color: Color.fromARGB(255, 121, 134, 203),
    ),
    RecordType.otherExpenses: RecordTypeStyle(
      icon: Icons.more_horiz,
      displayedName: 'Other Expenses',
      color: Color.fromARGB(255, 100, 181, 246),
    ),
  };
}
