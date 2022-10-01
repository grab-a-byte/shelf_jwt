import 'dart:convert';

import 'package:shelf_jwt/src/jwt/verification_factory.dart';

import 'jwt/encoding_factory.dart';
import 'jwt/jwt_header.dart';
import 'jwt/jwt_payload.dart';
import 'jwt/jwt_token.dart';

import 'infrastructure/result.dart';

String createJwt(JwtToken token, String secret) {
  final data =
      '${token.header.toEncodedString()}.${token.payload.toEncodedString()}';

  final sig = encodingFactory(token, secret);

  return '$data.$sig';
}

Result<JwtToken> decodeJwt(String token, String secret) {
  var paddedSections = token
      .split('.')
      .map((e) => base64Url.normalize(e))
      .map((e) => base64Url.decode(e))
      .map((e) => String.fromCharCodes(e))
      .toList();

  final header = JwtHeader.fromJsonString(paddedSections[0]);
  final payload = JwtPayload.fromJsonString(paddedSections[1]);

  final jwtToken = JwtToken(header, payload);

  final verified = verificationFactory(jwtToken, token.split('.')[2], secret);

  if (verified) {
    return Result.success(jwtToken);
  } else {
    return Result.faliure('Unable to verify signature');
  }
}
