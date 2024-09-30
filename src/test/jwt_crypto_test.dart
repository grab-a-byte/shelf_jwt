import 'package:shelf_jwt/src/infrastructure/result.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:shelf_jwt/src/jwt/jwt_token.dart';
import 'package:shelf_jwt/src/jwt_crypto.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_helpers.dart';

void main() {
  final token = JwtToken(
    JwtHeader(AlgorithmType.HS256, 'JWT'),
    JwtPayload('bobross.com', DateTime(2022, 1), DateTime(2022, 2), null),
  );

  const secret = 'secret';

  final sha256EncrytpedToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJib2Jyb3NzLmNvbSIsImlhdCI6MTY0MDk5NTIwMCwiZXhwIjoxNjQzNjczNjAwfQ.S5quKQ4TgMTXYv0_gYZpMhuhv_WaWhd5Dkt8QWBAy5o'
          .removeAllWhitespace();

  group('JWT Crypto', () {
    test('Serializes correctly', () {
      final serialized = createJwt(token, secret).removeAllWhitespace();

      expect(serialized, sha256EncrytpedToken);
    });

    test('Deserializes correctly', () {
      Result<JwtToken> tokenResult = decodeJwt(sha256EncrytpedToken, secret);
      var result = tokenResult.data!;
      expect(result.header, token.header);
      expect(result.payload, token.payload);
    });
  });
}
