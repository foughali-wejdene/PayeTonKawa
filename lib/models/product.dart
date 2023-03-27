class Product {
  String id;
  String name;
  String createdAt;
  String? image;
  Map<String, dynamic> details;
  int? quantity = 0;
  int stock;

  Product({required this.id, required this.name, this.image, required this.createdAt, required this.details, required this.stock, this.quantity});

  Product.fromMap(Map map)
      : this(
            id: map['id'],
            name: map['name'],
            createdAt: map['createdAt'],
            image: map['image'],
            details: map['details'],
            stock: map['stock'],
            quantity: (map['quantity'] != null) ? map['quantity'] : 0);

  Map<String, dynamic> asMap() => {'id': id, 'name': name, 'createdAt': createdAt, 'image': image, 'details': details, 'stock': stock, 'quantity': quantity};
}
