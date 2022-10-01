import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shelf_jwt/src/extensions/base64url_extensions.dart';
import 'package:shelf_jwt/src/jwt/jwt_token.dart';

class HS256 {
  static String encode(String str, String secret) {
    final hmac = Hmac(sha256, secret.codeUnits);
    return base64Url
        .encodeUnpaddedFromBytes(hmac.convert(utf8.encode(str)).bytes);
  }

  static bool validate(JwtToken token, String signature, String secret) {
    final encodedPayload =
        '${token.header.toEncodedString()}.${token.payload.toEncodedString()}';
    final sig = HS256.encode(encodedPayload, secret);

    return sig == signature;
  }
}
