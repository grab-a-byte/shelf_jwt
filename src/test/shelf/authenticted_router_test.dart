import 'package:shelf/shelf.dart';
import 'package:shelf_jwt/jwt.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';
import 'package:shelf_jwt/src/jwt/jwt_header.dart';
import 'package:shelf_jwt/src/jwt/jwt_payload.dart';
import 'package:shelf_jwt/src/shelf/authenticated_router.dart';
import 'package:shelf_jwt/src/user_management/in_memory_user_management.dart';
import 'package:shelf_jwt/src/user_management/user.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final adminUser = User('bob-ross', 'password', ['Admin']);
  final adminJwtToken = JwtToken(
      JwtHeader(AlgorithmType.HS256, 'typ'),
      JwtPayload(null, DateTime.now(), DateTime.now()..add(Duration(days: 1)),
          adminUser.entitlements.toList()));
  final adminToken = createJwt(adminJwtToken, 'secret');

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

    test(
        'Is able to make a get request to an authenticated endpoint with valid token',
        () async {
      final router = getAuthenticatedRouter(users: [adminUser])
        ..authenticatedGet(
            '/test', ['Admin'], (request) => Response.ok('Hello World'));

      final Response response = await router.getRouter().call(Request(
          'GET', Uri.parse('http://localhost:9999/test'),
          headers: {'authorization': adminToken}));

      expect(response.statusCode, 200);
      expect(await response.readAsString(), 'Hello World');
    });

    test(
        'Is unable to make a get request to an authenticated endpoint with no token',
        () async {
      final router = getAuthenticatedRouter(users: [adminUser])
        ..authenticatedGet(
            '/test', ['Admin'], (request) => Response.ok('Hello World'));

      final Response response = await router
          .getRouter()
          .call(Request('GET', Uri.parse('http://localhost:9999/test')));

      expect(response.statusCode, 403);
    });

    test(
        'Is unable to make a get request to an authenticated endpoint without valid entitlements',
        () async {
      final router = getAuthenticatedRouter(users: [adminUser])
        ..authenticatedGet(
            '/test', ['Super'], (request) => Response.ok('Hello World'));

      final Response response = await router.getRouter().call(Request(
          'GET', Uri.parse('http://localhost:9999/test'),
          headers: {'Authentication': adminToken}));

      expect(response.statusCode, 403);
    });

    test(
        'Is able to make a post request to an authenticated endpoint with valid token',
        () async {
      final router = getAuthenticatedRouter(users: [adminUser])
        ..authenticatedPost(
            '/test', ['Admin'], (request) => Response.ok('Hello Post'));

      final Response response = await router.getRouter().call(Request(
          'POST', Uri.parse('http://localhost:9999/test'),
          headers: {'authorization': adminToken}));

      expect(response.statusCode, 200);
      expect(await response.readAsString(), 'Hello Post');
    });

    test(
        'Is unable to make a get request to an authenticated endpoint with no token',
        () async {
      final router = getAuthenticatedRouter(users: [adminUser])
        ..authenticatedPost(
            '/test', ['Admin'], (request) => Response.ok('Hello Post'));

      final Response response = await router
          .getRouter()
          .call(Request('POST', Uri.parse('http://localhost:9999/test')));

      expect(response.statusCode, 403);
    });

    test(
        'Is unable to make a get request to an authenticated endpoint without valid entitlements',
        () async {
      final router = getAuthenticatedRouter(users: [adminUser])
        ..authenticatedPost(
            '/test', ['Super'], (request) => Response.ok('Hello Post'));

      final Response response = await router.getRouter().call(Request(
          'POST', Uri.parse('http://localhost:9999/test'),
          headers: {'Authentication': adminToken}));

      expect(response.statusCode, 403);
    });

    //TODO Add test for add login method
  });
}

AuthenticatedRouter getAuthenticatedRouter({List<User> users = const []}) {
  final userManager = InMemoryUserManagement();
  for (var user in users) {
    userManager.addUser(user);
  }
  return AuthenticatedRouter(Router(), userManager, 'secret');
}
