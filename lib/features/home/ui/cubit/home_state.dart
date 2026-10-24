import 'package:ecommerce_app_huma_volve/core/utils/resource.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';

class HomeState {
  late Resource<List<Category>> categoriesApi;
  late Resource<List<Product>> productsApi;
  final String searchQuery;
  final String? selectedCategoryId;

  HomeState({
    required this.categoriesApi,
    required this.productsApi,
    this.searchQuery = '',
    this.selectedCategoryId,
  });

  HomeState.initial() : searchQuery = '', selectedCategoryId = null {
    categoriesApi = Resource.initial();
    productsApi = Resource.initial();
  }

  List<Product> get filteredProducts {
    final allProducts = productsApi.data ?? [];
    if (searchQuery.isEmpty) return allProducts;
    final q = searchQuery.toLowerCase();
    return allProducts
        .where((p) => (p.title ?? '').toLowerCase().contains(q))
        .toList();
  }

  HomeState copyWith({
    Resource<List<Category>>? categoriesApi,
    Resource<List<Product>>? productsApi,
    String? searchQuery,
    String? selectedCategoryId,
    bool resetSelectedCategory = false,
  }) {
    return HomeState(
      categoriesApi: categoriesApi ?? this.categoriesApi,
      productsApi: productsApi ?? this.productsApi,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: resetSelectedCategory
          ? null
          : selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}
