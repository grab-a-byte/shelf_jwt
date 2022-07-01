import 'package:shelf/shelf.dart';
import 'package:shelf_jwt/src/shelf/authenticated_router.dart';
import 'package:shelf_jwt/src/user_management/in_memory_user_management.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('AuthenticatedRouter', () {
    test(
        'Is able to make a GET request to an unauthenticated route without a token',
        () async {
      final router = getAuthenticatedRouter()
        ..unauthenticatedGet('/test', (request) => Response.ok('Hello World'));

      final Response response = await router
          .getRouter()
          .call(Request('GET', Uri.parse('http://localhost:9999/test')));

      expect(response.statusCode, 200);
      expect(await response.readAsString(), 'Hello World');
    });

    test(
        'Is able to make a POST request to an unauthenticated route without a token',
        () async {
      final router = getAuthenticatedRouter()
        ..unauthenticatedPost('/test', (request) => Response.ok('Hello World'));

      final Response response = await router
          .getRouter()
          .call(Request('POST', Uri.parse('http://localhost:9999/test')));

      expect(response.statusCode, 200);
      expect(await response.readAsString(), 'Hello World');
    });
  });
}

AuthenticatedRouter getAuthenticatedRouter() =>
    AuthenticatedRouter(Router(), InMemoryUserManagement());
