import 'package:shelf_jwt/src/user_management/user.dart';

import '../infrastructure/result.dart';

abstract class UserManagement<T extends User> {
  void addUser(T user);
  Result<T> getUser(String username, String password);
}
