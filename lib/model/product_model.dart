class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description; // New field

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}