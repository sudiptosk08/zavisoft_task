class FakestoreUser {
  final int id;
  final String email;
  final String username;
  final String phone;
  final String fullName;
  final String city;
  final String street;

  FakestoreUser({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.fullName,
    required this.city,
    required this.street,
  });

  factory FakestoreUser.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map<String, dynamic>? ?? {};
    final address = json['address'] as Map<String, dynamic>? ?? {};
    return FakestoreUser(
      id: json['id'] as int,
      email: json['email'] as String? ?? '',
      username: json['username'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      fullName:
          '${name['firstname'] ?? ''} ${name['lastname'] ?? ''}'.trim(),
      city: address['city'] as String? ?? '',
      street: address['street'] as String? ?? '',
    );
  }
}


