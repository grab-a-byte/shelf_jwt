import 'package:shelf_jwt/src/jwt/encodings/hs256.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_token.dart';

bool verificationFactory(JwtToken token, String signature, String secret) {
  switch (token.header.alg) {
    case AlgorithmType.HS256:
      return HS256.validate(token, signature, secret);
    default:
      return false;
  }
}
