import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/core/api/api_services.dart';
import 'package:ecommerce_app_huma_volve/core/api/handle_dio_error.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/category_dm.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_dm.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices _apiServices;

  HomeRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<List<CategoryDM>>> getCategories() async {
    try {
      var response = await _apiServices.getCategories();
      return SuccessApiResult(data: response);
    } on DioException catch (e) {
      return handleApiErrors(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<List<ProductDM>>> getProducts({
    String? category,
    required int offset,
    required int limit,
  }) async {
    try {
      var response = await _apiServices.getProducts(
        category: category,
        offset: offset,
        limit: limit,
      );
      return SuccessApiResult(data: response);
    } catch (e) {
      return handleApiErrors(e);
    }
  }

  @override
  Future<ApiResult<ProductDM>> getProductById(String id) async {
    try {
      final response = await _apiServices.getProductById(id);
      return SuccessApiResult(data: response);
    } catch (error) {
      return handleApiErrors(error);
    }
  }
}
