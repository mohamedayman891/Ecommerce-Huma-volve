import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/response/auth/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<AuthResponse>> login(LoginRequest request);
  Future<ApiResult<AuthResponse>> register(RegisterRequest request);
}
