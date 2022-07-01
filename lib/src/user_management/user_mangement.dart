import 'package:shelf_jwt/src/user_management/user.dart';

abstract class UserManagement<T extends User> {
  void addUser(T user);
  T getUser(String username, String password);
}
