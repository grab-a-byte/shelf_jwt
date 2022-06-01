import 'package:shelf_jwt/src/jwt/encodings/hs256.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:shelf_jwt/src/jwt/jwt_token.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('HS256', () {
    test('contains no padding when encoded', () {
      final result = HS256.encode('abc', 'secret');
      expect(result.contains('='), false);
    });

    test('is able to validate a signature', () {
      final token = JwtToken(
        JwtHeader(AlgorithmType.HS256, 'JWT'),
        JwtPayload('bobross.com', DateTime(2022, 1), DateTime(2022, 2), null),
      );
      final signature = 'S5quKQ4TgMTXYv0_gYZpMhuhv_WaWhd5Dkt8QWBAy5o';

      final result = HS256.validate(token, signature, 'secret');

      expect(result, true);
    });
  });
}
