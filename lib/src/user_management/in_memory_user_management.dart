import 'package:shelf_jwt/src/user_management/user.dart';
import 'package:shelf_jwt/src/user_management/user_mangement.dart';

class InMemoryUserManagement implements UserManagement<User> {
  final List<User> _users = [];

  @override
  void addUser(User user) => _users.add(user);

  @override
  User getUser(String username, String password) =>
      _users.firstWhere((element) =>
          element.username == username && element.password == password);
}
