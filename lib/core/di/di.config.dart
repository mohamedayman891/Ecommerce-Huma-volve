// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/data_sources/auth_remote_data_source_impl.dart'
    as _i182;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/ui/login/cubit/login_cubit.dart' as _i416;
import '../../features/auth/ui/sign_up/cubit/register_cubit.dart' as _i951;
import '../../features/home/data/data_source/remote_data_source/home_remote_data_source.dart'
    as _i3;
import '../../features/home/data/data_source/remote_data_source/home_remote_data_source_impl.dart'
    as _i128;
import '../../features/home/data/mapper/category_mapper.dart' as _i1060;
import '../../features/home/data/mapper/product_mapper.dart' as _i937;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/usecase/get_categories_usecase.dart'
    as _i493;
import '../../features/home/domain/usecase/get_products_usecase.dart' as _i271;
import '../../features/home/ui/cubit/home_cubit.dart' as _i333;
import '../api/api_services.dart' as _i124;
import '../shared_pref_utils/shared_pref_utils.dart' as _i420;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i1060.CategoriesMapper>(() => _i1060.CategoriesMapper());
    gh.factory<_i937.ProductsMapper>(() => _i937.ProductsMapper());
    gh.singleton<_i420.SharedPrefUtils>(() => _i420.SharedPrefUtils());
    gh.factory<_i124.ApiServices>(() => _i124.ApiServices(gh<_i361.Dio>()));
    gh.factory<_i3.HomeRemoteDataSource>(
      () => _i128.HomeRemoteDataSourceImpl(gh<_i124.ApiServices>()),
    );
    gh.factory<_i25.AuthRemoteDataSource>(
      () => _i182.AuthRemoteDataSourceImpl(gh<_i124.ApiServices>()),
    );
    gh.factory<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(
        gh<_i25.AuthRemoteDataSource>(),
        gh<_i420.SharedPrefUtils>(),
      ),
    );
    gh.factory<_i541.HomeRepository>(
      () => _i9.HomeRepositoryImpl(
        gh<_i3.HomeRemoteDataSource>(),
        gh<_i1060.CategoriesMapper>(),
        gh<_i937.ProductsMapper>(),
      ),
    );
    gh.factory<_i271.GetProductsUseCase>(
      () => _i271.GetProductsUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i911.LoginUseCase>(
      () => _i911.LoginUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i769.RegisterUseCase>(
      () => _i769.RegisterUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i493.GetCategoriesUseCase>(
      () => _i493.GetCategoriesUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i951.RegisterCubit>(
      () => _i951.RegisterCubit(gh<_i769.RegisterUseCase>()),
    );
    gh.factory<_i416.LoginCubit>(
      () => _i416.LoginCubit(gh<_i911.LoginUseCase>()),
    );
    gh.factory<_i333.HomeCubit>(
      () => _i333.HomeCubit(
        gh<_i493.GetCategoriesUseCase>(),
        gh<_i271.GetProductsUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}
