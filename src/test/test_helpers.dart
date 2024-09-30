import 'package:test/expect.dart';

extension StringExtensions on String {
  String removeAllWhitespace() => replaceAll('\n', '').replaceAll(' ', '');
}

expectFalse() {
  expect(false, true);
}

expectTrue() {
  expect(true, true);
}
