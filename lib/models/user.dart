class User {
  final String id;
  final String fullName;
  final String email;
  final String gender;

  User({this.id, this.fullName, this.email, this.gender});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        gender = data['gender'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'gender': gender,
    };
  }
}
