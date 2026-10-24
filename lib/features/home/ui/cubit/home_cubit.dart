import 'package:ecommerce_app_huma_volve/core/utils/resource.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecase/get_products_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/ui/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;
  int _productsCategoryId = 0;

  HomeCubit(this._getCategoriesUseCase, this._getProductsUseCase)
    : super(HomeState.initial());

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesApi: Resource.loading()));
    var apiResult = await _getCategoriesUseCase.call();
    if (apiResult.isSuccess) {
      emit(
        state.copyWith(
          categoriesApi: Resource.success(data: apiResult.getData()),
        ),
      );
    } else {
      emit(
        state.copyWith(
          categoriesApi: Resource.error(errorMessage: apiResult.errorMessage),
        ),
      );
    }
  }

  Future<void> getProducts({String? category}) async {
    final categoryId = ++_productsCategoryId;
    emit(
      state.copyWith(
        productsApi: Resource.loading(),
        selectedCategoryId: category,
        resetSelectedCategory: category == null,
      ),
    );
    final apiResult = await _getProductsUseCase.call(category: category);
    if (isClosed || categoryId != _productsCategoryId) return;
    if (apiResult.isSuccess) {
      emit(
        state.copyWith(
          productsApi: Resource.success(data: apiResult.getData()),
        ),
      );
    } else {
      emit(
        state.copyWith(
          productsApi: Resource.error(errorMessage: apiResult.errorMessage),
        ),
      );
    }
  }

  void searchProducts(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
