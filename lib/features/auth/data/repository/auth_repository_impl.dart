import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/core/shared_pref_utils/shared_pref_utils.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SharedPrefUtils _sharedPrefUtils;

  AuthRepositoryImpl(this._authRemoteDataSource, this._sharedPrefUtils);

  ///This method will be used by UseCase
  @override
  Future<ApiResult<void>> login(LoginRequest request) async {
    var authResponse = await _authRemoteDataSource.login(request);
    if (authResponse.isSuccess && authResponse.getData()?.token != null) {
      await _sharedPrefUtils.saveToken(authResponse.getData()!.token!);
    }
    return authResponse;
  }

  @override
  Future<ApiResult<void>> register(RegisterRequest request) async {
    var authResponse = await _authRemoteDataSource.register(request);
    if (authResponse.isSuccess && authResponse.getData()?.token != null) {
      await _sharedPrefUtils.saveToken(authResponse.getData()!.token!);
    }
    return authResponse;
  }
}
