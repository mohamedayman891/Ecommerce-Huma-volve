import 'package:ecommerce_app_huma_volve/core/utils/resource.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/auth/ui/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase)
    : super(LoginState(loginApi: Resource.initial()));

  ///This method will be used by widget
  Future<void> login(String email, String password) async {
    emit(LoginState(loginApi: Resource.loading()));
    var authResponse = await _loginUseCase.call(
      LoginRequest(email: email, password: password),
    );
    if (authResponse.isSuccess) {
      emit(LoginState(loginApi: Resource.success()));
    } else {
      emit(
        LoginState(
          loginApi: Resource.error(errorMessage: authResponse.errorMessage),
        ),
      );
    }
  }
}
