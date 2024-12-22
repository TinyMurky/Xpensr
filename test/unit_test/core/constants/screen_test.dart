import 'package:flutter_test/flutter_test.dart';

import 'package:xpensr/core/constants/screen.dart';

void main() {
  group('ScreenEnum Tests', () {
    test('ScreenEnum Can Be Get By Extension FromIndex', () {
      final testScreen = ScreenEnumsExtension.fromIndex(0);
      expect(testScreen, ScreenEnums.bookKeeping);
    });
  });
}
