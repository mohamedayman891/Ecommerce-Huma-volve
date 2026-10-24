import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/request/register_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/model/auth/response/auth/auth_response.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/category_dm.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_dm.dart';
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

  @GET('products')
  Future<List<ProductDM>> getProducts({@Query("categoryId") String? category});
  @GET('categories')
  Future<List<CategoryDM>> getCategories();
}
