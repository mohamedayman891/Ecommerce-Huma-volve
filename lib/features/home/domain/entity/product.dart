class Product {
  String? id;
  String? title;
  String? slug;
  String? categoryName;
  int? price;
  String? description;
  List<String>? images;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    this.categoryName,
    required this.price,
    required this.description,
    required this.images,
  });
}
