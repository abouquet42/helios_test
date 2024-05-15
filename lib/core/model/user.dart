class User {
  final Name name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: Name.fromJson(json['name']),
      email: json['email'],
    );
  }
}

class Name {
  final String first;
  final String last;

  Name({required this.first, required this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      last: json['last'],
    );
  }
}
