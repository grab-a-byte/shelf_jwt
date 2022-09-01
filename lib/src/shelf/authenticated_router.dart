import 'package:shelf/shelf.dart';
import 'package:shelf_jwt/jwt.dart';
import 'package:shelf_jwt/src/user_management/user_mangement.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthenticatedRouter {
  final Router _router;
  final UserManagement _userManagement;
  final String _secret;

  AuthenticatedRouter(this._router, this._userManagement, this._secret);

  void unauthenticatedGet(String route, Handler handler) {
    _router.get(route, handler);
  }

  void unauthenticatedPost(String route, Handler handler) {
    _router.post(route, handler);
  }

  Router getRouter() => _router;

  void authenticatedGet(
      String route, List<String> validClaims, Handler handler) {
    _router.get(route, (Request req) {
      final authHeader = req.headers['Authentication'];
      if (authHeader == null) {
        return Response(403, body: "Unathenticated");
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
