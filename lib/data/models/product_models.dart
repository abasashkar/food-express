class Product {
  final String id;
  final String name;
  final String image;
  final int price;
  final String gender;
  final String category;
  final String description;
  final String size;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.gender,
    required this.category,
    required this.description,
    required this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? 0,
      gender: json['Gender'] ?? '',
      category: json['Category'] ?? '',
      description: json['description'] ?? '',
      size: json['size'] ?? '',
    );
  }
}
