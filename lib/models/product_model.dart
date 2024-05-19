class Product {
  String name;
  String description;
  String? photo;

  Product({
    required this.name,
    required this.description,
    this.photo,
  });
}
