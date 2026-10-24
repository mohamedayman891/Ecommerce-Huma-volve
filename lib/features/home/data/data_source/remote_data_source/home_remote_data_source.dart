import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/category_dm.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_dm.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<List<ProductDM>>> getProducts({
    String? category,
    String? subCategory,
  });
  Future<ApiResult<List<CategoryDM>>> getCategories();
}
