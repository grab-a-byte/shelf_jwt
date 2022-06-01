import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../test_helpers.dart';

void main() {
  group('JWT Payload test', () {
    final json = '''
      {
        "iss": "bobross.com",
        "iat": 1640995200,
        "exp": 1643673600,
        "entitlements": ["hello", "world"]
      }
    '''
        .removeAllWhitespace();

    test('serializes to json correctly', () {
      final payload = JwtPayload(
          "bobross.com", DateTime(2022), DateTime(2022, 2), ['hello', 'world']);

      final payloadJson = payload.toJsonString().removeAllWhitespace();
      expect(payloadJson, json);
    });
    test('deserializes from json correctly', () {
      final payload = JwtPayload(
          "bobross.com", DateTime(2022), DateTime(2022, 2), ['hello', 'world']);

      final payloadJson = payload.toJsonString();
      expect(payloadJson, json);
    });
  });
}
