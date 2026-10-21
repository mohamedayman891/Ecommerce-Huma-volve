import 'package:ecommerce_app_huma_volve/core/utils/resource.dart';

class LoginState {
  Resource<void> loginApi = Resource.initial();

  LoginState({required this.loginApi});
}
