class Product {
  String? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  List<String>? images;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.images,
  });
}
