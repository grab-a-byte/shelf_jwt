class User {
  final String username;
  final String password;
  final Iterable<String> entitlements;

  User(this.username, this.password, this.entitlements);
}
