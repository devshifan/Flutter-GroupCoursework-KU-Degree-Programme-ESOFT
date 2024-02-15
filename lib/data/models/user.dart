class User {
  late int? id;
  late String? username;
  late String? email;
  late String? password;
  late bool? isActiveUser;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.isActiveUser,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      isActiveUser: map['isActiveUser'] == 1, // Convert 1 to true, 0 to false
    );
  }

  Map<String, dynamic> userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['username'] = username ?? '';
    mapping['email'] = email ?? '';
    mapping['password'] = password ?? '';
    mapping['isActiveUser'] =
        isActiveUser == true ? 1 : 0; // Convert true to 1, false to 0
    return mapping;
  }
}
