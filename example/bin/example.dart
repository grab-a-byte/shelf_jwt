import 'package:shelf/shelf.dart';
import 'package:shelf_jwt/shelf_jwt.dart';
import 'package:shelf_jwt/src/user_management/user.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

Future<void> main() async {
  final userManager = InMemoryUserManagement()
    ..addUser(User('User1', 'Password1', ['User']));

  var authRouter = AuthenticatedRouter(Router(), userManager, "secret");

  authRouter.addLogin('/Login');

  authRouter.unauthenticatedGet(
      '/test', (request) => Response.ok('unauthenticated test'));

  authRouter.authenticatedGet(
      '/authtest', ['User'], (request) => Response.ok('authenticated test'));

  authRouter.authenticatedPost('/authtest', ['User'],
      (request) => Response.ok('authenticated post test'));

  print('Running on port 8080');
  await io.serve(authRouter.getRouter(), 'localhost', 8080);
}
