import 'package:shelf/shelf.dart';
import 'package:shelf_jwt/src/user_management/user_mangement.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthenticatedRouter {
  final Router _router;
  final UserManagement _userManagement;

  AuthenticatedRouter(this._router, this._userManagement);

  void unauthenticatedGet(String route, Handler handler) {
    _router.get(route, handler);
  }

  void unauthenticatedPost(String route, Handler handler) {
    _router.post(route, handler);
  }

  Router getRouter() => _router;
}
