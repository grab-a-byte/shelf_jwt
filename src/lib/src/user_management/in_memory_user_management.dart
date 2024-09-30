import 'package:shelf_jwt/src/user_management/user.dart';
import 'package:shelf_jwt/src/user_management/user_mangement.dart';

import '../infrastructure/result.dart';

class InMemoryUserManagement implements UserManagement<User> {
  final List<User> _users = [];

  @override
  void addUser(User user) => _users.add(user);

  @override
  Result<User> getUser(String username, String password) {
    try {
      var user = _users.firstWhere((element) =>
          element.username == username && element.password == password);
      return Result.success(user);
    } on StateError catch (_) {
      return Result.faliure('Unable to find user');
    }
  }
}
