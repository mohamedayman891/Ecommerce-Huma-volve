import 'package:ecommerce_app_huma_volve/core/api/api_result.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  ///This method will be used by ViewModel(cubit)
  Future<ApiResult<void>> call(RegisterRequest request) =>
      _authRepository.register(request);
}
