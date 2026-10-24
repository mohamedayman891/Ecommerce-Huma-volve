import 'package:ecommerce_app_huma_volve/features/home/data/model/product_dm.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsMapper {
  Product toEntity(ProductDM productDM) => Product(
    images: productDM.images ?? [],
    id: productDM.id ?? "",
    title: productDM.title ?? "",
    description: productDM.description ?? "",
    price: productDM.price ?? 0,
    slug: productDM.slug,
  );

  List<Product> toEntities(List<ProductDM> products) =>
      products.map(toEntity).toList();
}
