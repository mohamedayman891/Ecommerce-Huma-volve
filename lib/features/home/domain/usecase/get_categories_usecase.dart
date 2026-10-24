import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<ApiResult<List<Category>>> call() => _repository.getCategories();
}
