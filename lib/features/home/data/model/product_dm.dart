import 'package:ecommerce_app_huma_volve/features/home/data/model/category_dm.dart';

class ProductDM {
  String? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryDM? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductDM({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  ProductDM.fromJson(Map<String, dynamic> json) {
    // The API sends numeric IDs; keep them as strings in the domain layer.
    id = json['id']?.toString();
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryDM.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['images'] = images;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
