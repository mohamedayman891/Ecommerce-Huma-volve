import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/mapper/category_mapper.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/mapper/product_mapper.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final CategoriesMapper _categoriesMapper;
  final ProductsMapper _productsMapper;

  HomeRepositoryImpl(
    this._remoteDataSource,
    this._categoriesMapper,
    this._productsMapper,
  );

  @override
  Future<ApiResult<List<Category>>> getCategories() async {
    try {
      var apiResult = await _remoteDataSource.getCategories();
      if (apiResult.isSuccess) {
        return SuccessApiResult(
          data: _categoriesMapper.toEntities(apiResult.getData() ?? []),
        );
      } else {
        return FailureApiResult(apiResult.getError()!);
      }
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<List<Product>>> getProducts({
    String? category,
    String? subCategory,
  }) async {
    try {
      var apiResult = await _remoteDataSource.getProducts(
        category: category,
        subCategory: subCategory,
      );
      if (apiResult.isSuccess) {
        return SuccessApiResult(
          data: _productsMapper.toEntities(apiResult.getData() ?? []),
        );
      } else {
        return FailureApiResult(apiResult.getError()!);
      }
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
