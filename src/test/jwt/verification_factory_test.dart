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

    test('Returns Successfully when HS256 token is valid', () {
      final token = JwtToken(
        JwtHeader(AlgorithmType.HS256, 'JWT'),
        JwtPayload('bobross.com', DateTime(2022, 1), DateTime(2022, 2), null),
      );

      final signature = 'S5quKQ4TgMTXYv0_gYZpMhuhv_WaWhd5Dkt8QWBAy5o';

      final result = verificationFactory(token, signature, 'secret');

      expect(result, true);
    });
  });
}
