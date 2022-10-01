import 'package:shelf_jwt/src/jwt/encoding_factory.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:shelf_jwt/src/jwt/jwt_token.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../test_helpers.dart';

void main() {
  group('Encoding Factory', () {
    test('Unsupported type throws exception', () {
      final token = JwtToken(JwtHeader(AlgorithmType.UNSUPPORTED, 'typ'),
          JwtPayload(null, DateTime.now(), DateTime.now(), null));

      try {
        encodingFactory(token, 'test');
        expectFalse();
      } on Exception catch (e) {
        expect(e.toString(), 'Exception: Unsupported Algorithm Type');
      }
    });

    test('Supported type does not thow an exception', () {
      final token = JwtToken(JwtHeader(AlgorithmType.HS256, 'typ'),
          JwtPayload(null, DateTime.now(), DateTime.now(), null));

      final result = encodingFactory(token, 'test');
      expect(result.isEmpty, false);
    });
  });
}
