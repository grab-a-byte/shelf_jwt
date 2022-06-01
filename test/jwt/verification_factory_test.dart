//TODO verification facotry tests
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:shelf_jwt/src/jwt/jwt_token.dart';
import 'package:shelf_jwt/src/jwt/verification_factory.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Verification Factory', () {
    test('Fails automatically if header type unsupported', () {
      final token = JwtToken(JwtHeader(AlgorithmType.UNSUPPORTED, 'typ'),
          JwtPayload(null, DateTime.now(), DateTime.now(), null));
      final result = verificationFactory(token, 'abc', 'secret');

      expect(result, false);
    });
  });
}
