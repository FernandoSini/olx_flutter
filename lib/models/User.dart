enum UserType {
  PARTICULAR,
  PROFESSIONAL
} /* particular = 0 e professional = 1 */

class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.type = UserType.PARTICULAR,
      this.createdAt});

  String id;
  String name;
  String email;
  String phone;
  String password;
  UserType type;
  DateTime createdAt;

  @override
  String toString() {
    return 'User {id="' +
        id +
        '", name="' +
        name +
        '", email="' +
        email +
        '", phone="' +
        phone +
        '", type="' +
        type.toString() +
        '", createdAt="' +
        createdAt.toString() +
        '"}';
  }
}
