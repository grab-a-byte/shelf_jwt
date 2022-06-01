//TODO Tests for datetime extension
import 'package:shelf_jwt/src/extensions/datetime_extensions.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Date Time Extensions', () {
    test('Is able to read from seconds since epoch', () {
      final result = DateTimeExtensions.fromSecondsSinceEpoch(1640995200);
      final expected = DateTime(2022, 1);

      expect(result, expected);
    });
  });
}
