class User {
  String id;
  String name;
  Map<String, dynamic>? address;
  Map<String, dynamic>? profile;
  Map<String, dynamic>? company;
  String? email;
  List<dynamic>? orders;

  User(
      {required this.id,
      required this.name,
      this.email});

  User.fromMap(Map map)
      : this(
            id: map['id'],
            name: map['name'],
            email: map['email']);

  Map<String, dynamic> asMap() => {
        'id': id,
        'name': name,
        'email': email,
        'address': address,
        'profile': profile,
        'company': company,
        'orders': orders
      };
}
