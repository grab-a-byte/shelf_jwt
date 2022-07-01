//TODO Implement
import 'package:shelf_jwt/src/user_management/in_memory_user_management.dart';
import 'package:shelf_jwt/src/user_management/user.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('In memory user management', () {
    test('Is able to retrieve added user', () {
      var userManager = InMemoryUserManagement();
      var user = User('bob', 'ross', ['painting', 'happiness']);
      userManager.addUser(user);
      var retrievedUser = userManager.getUser('bob', 'ross');
      expect(retrievedUser, user);
    });
  });
}
