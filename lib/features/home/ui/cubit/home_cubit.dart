import 'package:ecommerce_app_huma_volve/core/utils/resource.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecase/get_products_usecase.dart';
import 'package:ecommerce_app_huma_volve/features/home/ui/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  static const int _pageSize = 10;

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
        hasMoreProducts: true,
        isLoadingMoreProducts: false,
        clearPaginationError: true,
      ),
    );
    final apiResult = await _getProductsUseCase.call(
      category: category,
      offset: 0,
      limit: _pageSize,
    );
    if (isClosed || categoryId != _productsCategoryId) return;
    if (apiResult.isSuccess) {
      final products = apiResult.getData() ?? [];
      emit(
        state.copyWith(
          productsApi: Resource.success(data: products),
          hasMoreProducts: products.length >= _pageSize,
        ),
      );
    } else {
      emit(
        state.copyWith(
          productsApi: Resource.error(errorMessage: apiResult.errorMessage),
          hasMoreProducts: false,
        ),
      );
    }
  }

  Future<void> loadMoreProducts({bool retry = false}) async {
    if (isClosed ||
        state.productsApi.isLoading ||
        state.productsApi.isError ||
        !state.hasMoreProducts ||
        state.isLoadingMoreProducts ||
        (state.paginationError != null && !retry)) {
      return;
    }

    final categoryId = _productsCategoryId;
    final currentProducts = state.productsApi.data ?? [];

    emit(
      state.copyWith(isLoadingMoreProducts: true, clearPaginationError: true),
    );

    final apiResult = await _getProductsUseCase.call(
      category: state.selectedCategoryId,
      offset: currentProducts.length,
      limit: _pageSize,
    );
    if (isClosed || categoryId != _productsCategoryId) return;

    if (apiResult.isSuccess) {
      final nextPage = apiResult.getData() ?? [];
      emit(
        state.copyWith(
          productsApi: Resource.success(
            data: [...currentProducts, ...nextPage],
          ),
          hasMoreProducts: nextPage.length >= _pageSize,
          isLoadingMoreProducts: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoadingMoreProducts: false,
          paginationError: apiResult.errorMessage,
        ),
      );
    }
  }

  void searchProducts(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
