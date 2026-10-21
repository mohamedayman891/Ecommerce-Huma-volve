import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/core/model/auth/response/auth/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'api_services.g.dart';

///This is created by retrofit
@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST('auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('users')
  Future<AuthResponse> register(@Body() RegisterRequest request);
}
