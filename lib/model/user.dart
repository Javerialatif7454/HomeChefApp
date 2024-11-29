class User {
  int? id;
  String? username;
  String? fullname;
  String email;
  String password;
  String? phone; // Add the phone field

  User({
    this.id,
     this.username,
     this.fullname,
    required this.email,
    required this.password,
     this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'password': password,
      'phone': phone, // Map the phone field
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'], // Retrieve the phone field
    );
  }
}
