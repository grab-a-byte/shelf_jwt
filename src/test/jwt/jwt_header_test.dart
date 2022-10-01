import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../test_helpers.dart';

void main() {
  group('Jwt Header', () {
    test('serialzes to Json Correctly', () {
      final expectedJson = '''
        {
          "alg": "HS256",
          "typ": "JWT"
        }
        '''
          .removeAllWhitespace();

      final header = JwtHeader(AlgorithmType.HS256, 'JWT');
      final json = header.toJsonString();
      expect(json, expectedJson);
    });

    test('deserialzes to Json Correctly', () {
      final json = '''
{
  "alg": "HS256",
  "typ": "JWT"
}
'''
          .removeAllWhitespace();

      final header = JwtHeader(AlgorithmType.HS256, 'JWT');
      final result = JwtHeader.fromJsonString(json);
      expect(result, header);
    });
  });
}
