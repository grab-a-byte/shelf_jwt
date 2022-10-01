import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';

import 'encodings/hs256.dart';
import 'jwt_token.dart';

String encodingFactory(JwtToken token, String secret) {
  final data =
      '${token.header.toEncodedString()}.${token.payload.toEncodedString()}';

  switch (token.header.alg) {
    case AlgorithmType.HS256:
      return HS256.encode(data, secret);
    default:
      throw Exception('Unsupported Algorithm Type');
  }
}
