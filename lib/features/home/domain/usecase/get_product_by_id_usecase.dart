import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductByIdUseCase {
  final HomeRepository _repository;

  GetProductByIdUseCase(this._repository);

  Future<ApiResult<Product>> call(String id) => _repository.getProductById(id);
}
