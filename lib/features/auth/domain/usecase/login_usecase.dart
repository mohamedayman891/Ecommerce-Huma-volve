import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  ///This method will be used by ViewModel(cubit)
  Future<ApiResult<void>> call(LoginRequest request) =>
      _authRepository.login(request);
}
