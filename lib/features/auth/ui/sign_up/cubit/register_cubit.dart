import 'package:ecommerce_app_huma_volve/core/utils/resource.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecase/register_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/ui/sign_up/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase)
    : super(RegisterState(registerApi: Resource.initial()));
  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? role,
    String? avatar,
  }) async {
    emit(RegisterState(registerApi: Resource.loading()));
    var authResponse = await _registerUseCase.call(
      RegisterRequest(
        name: name,
        email: email,
        password: password,
        role: role,
        avatar: avatar,
      ),
    );
    if (authResponse.isSuccess) {
      emit(RegisterState(registerApi: Resource.success()));
    } else {
      emit(
        RegisterState(
          registerApi: Resource.error(errorMessage: authResponse.errorMessage),
        ),
      );
    }
  }
}
