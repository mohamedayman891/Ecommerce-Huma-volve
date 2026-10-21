import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/core/api/api_services.dart';
import 'package:ecommerce_app_huma_volve/core/api/handle_dio_error.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/response/auth/auth_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  ///This is created by retrofit
  final ApiServices _apiServices;
  AuthRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) async {
    try {
      var authResponse = await _apiServices.login(request);
      return SuccessApiResult(data: authResponse);
    } on DioException catch (e) {
      return handleApiErrors<AuthResponse>(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequest request) async {
    try {
      var authResponse = await _apiServices.register(request);
      return SuccessApiResult(data: authResponse);
    } on DioException catch (e) {
      return handleApiErrors<AuthResponse>(e);
    } catch (e) {
      return FailureApiResult(ServerError());
    }
  }
}
