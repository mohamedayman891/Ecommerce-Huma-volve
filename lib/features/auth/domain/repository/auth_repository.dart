import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/register_request.dart';

abstract class AuthRepository {
  Future<ApiResult<void>> login(LoginRequest request);
  Future<ApiResult<void>> register(RegisterRequest request);
}
