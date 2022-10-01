import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_jwt/jwt.dart';
import 'package:shelf_jwt/src/infrastructure/result.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:shelf_jwt/src/user_management/user.dart';
import 'package:shelf_jwt/src/user_management/user_mangement.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthenticatedRouter {
  final Router _router;
  final UserManagement _userManagement;
  final String _secret;

  AuthenticatedRouter(this._router, this._userManagement, this._secret);

  Router getRouter() => _router;

  void addLogin(String path) {
    _router.post(path, (Request req) async {
      try {
        String body = await req.readAsString();
        var json = jsonDecode(body) as Map<String, dynamic>;
        var username = json['username'] as String?;
        var password = json['password'] as String?;
        if (username == null || password == null) {
          return Response(403, body: "error");
        }
        Result<User> user = _userManagement.getUser(username, password);
        if (user.isError) {
          return Response(403, body: "No User");
        }

        var token = JwtToken(
            JwtHeader(AlgorithmType.HS256, "JWT"),
            JwtPayload(
                null,
                DateTime.now(),
                DateTime.now().add(Duration(hours: 1)),
                user.data!.entitlements.toList()));

        String stringToken = createJwt(token, _secret);
        return Response.ok(stringToken);
      } catch (_) {
        return Response(403, body: "error");
      }
    });
  }

  void unauthenticatedGet(String route, Handler handler) {
    _router.get(route, handler);
  }

  void unauthenticatedPost(String route, Handler handler) {
    _router.post(route, handler);
  }

  void authenticatedGet(
      String route, List<String> validClaims, Handler handler) {
    _router.get(route, (Request req) {
      var authHeader =
          req.headers['Authorization'] ?? req.headers['authorization'];
      if (authHeader == null) {
        return Response(403, body: "Unathenticated");
      }
      if (authHeader.contains('Bearer')) {
        authHeader = authHeader.replaceAll('Bearer', '').trim();
      }
      final jwt = decodeJwt(authHeader, _secret);
      if (jwt.isError) {
        return Response(403, body: jwt.errorMessage);
      }
      final jwtToken = jwt.data!;
      if (validClaims.isNotEmpty &&
          !validClaims.any(jwtToken.payload.entitlements!.contains)) {
        return Response(403, body: "Unathenticated");
      }
      return handler(req);
    });
  }

  void authenticatedPost(
      String route, List<String> validClaims, Handler handler) {
    throw Exception('NOT IMPLEMENTED');
  }
}
