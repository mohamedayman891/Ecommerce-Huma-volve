import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';

abstract class HomeRepository {
  Future<ApiResult<List<Category>>> getCategories();
  Future<ApiResult<List<Product>>> getProducts({
    required String? category,
    required int offset,
    required int limit,
  });
}
