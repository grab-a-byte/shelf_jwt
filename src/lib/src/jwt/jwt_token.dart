import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';

class JwtToken {
  final JwtHeader header;
  final JwtPayload payload;

  JwtToken(this.header, this.payload);
}
