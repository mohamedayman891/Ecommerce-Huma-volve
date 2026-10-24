import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final HomeRepository _homeRepository;

  GetProductsUseCase(this._homeRepository);

  Future<ApiResult<List<Product>>> call({
    String? category,
    String? subCategory,
  }) =>
      _homeRepository.getProducts(category: category, subCategory: subCategory);
}
