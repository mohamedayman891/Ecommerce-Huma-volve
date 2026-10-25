import 'package:ecommerce_app_huma_volve/core/di/di.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:ecommerce_app_huma_volve/features/home/ui/cubit/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/ui/cubit/home_state.dart';
import 'package:ecommerce_app_huma_volve/features/home/ui/screens/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/dummy_data.dart' hide Product;
import '../../../../core/utils/theme.dart';
import 'widgets/product_card.dart';
import 'widgets/category_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit cubit = getIt();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    cubit.getProducts();
    cubit.getCategories();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.extentAfter < 400) {
      _loadNextPage();
    }
  }

  void _loadNextPage() {
    cubit.loadMoreProducts();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: BlocProvider(
        create: (context) => cubit,
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.grey.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: AppTheme.primary,
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              dummyUser.profilePictureUrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Explore',
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(fontSize: 36),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Best trendy collection!',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      SearchTextField(
                        onSearchChanged: (query) => cubit.searchProducts(query),
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state.categoriesApi.isSuccess) {
                            final categories = state.categoriesApi.data ?? [];
                            if (categories.isEmpty) {
                              return const Text('No categories available');
                            }
                            return buildCategories(
                              categories,
                              selectedCategoryId: state.selectedCategoryId,
                              onCategorySelected: (categoryId) {
                                cubit.getProducts(category: categoryId);
                              },
                            );
                          } else if (state.categoriesApi.isError) {
                            return Text(
                              state.categoriesApi.errorMessage.isEmpty
                                  ? 'Could not load categories'
                                  : state.categoriesApi.errorMessage,
                              style: const TextStyle(color: AppTheme.accent),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.productsApi.isSuccess) {
                    final products = state.filteredProducts;
                    if (products.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              state.searchQuery.isEmpty
                                  ? 'No products available'
                                  : 'No products match your search',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      );
                    }
                    return buildProducts(products);
                  } else if (state.productsApi.isError) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            state.productsApi.errorMessage.isEmpty
                                ? 'Could not load products'
                                : state.productsApi.errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppTheme.accent),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) => buildPaginationFooter(state),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProducts(List<Product> product) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    sliver: SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProductCard(product: product[index]);
      }, childCount: product.length),
    ),
  );

  Widget buildPaginationFooter(HomeState state) {
    if (!state.productsApi.isSuccess ||
        state.productsApi.data?.isEmpty != false) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    if (state.isLoadingMoreProducts) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    if (state.paginationError != null) {
      return SliverToBoxAdapter(
        child: Center(
          child: TextButton(
            onPressed: _loadNextPage,
            child: const Text('Could not load more products. Tap to retry.'),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  Widget buildCategories(
    List<Category> categories, {
    required String? selectedCategoryId,
    required ValueChanged<String?> onCategorySelected,
  }) => SizedBox(
    height: 44,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length + 1,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final isAll = index == 0;
        final category = isAll ? null : categories[index - 1];
        final categoryId = category?.id;
        return CategoryChip(
          category: category ?? Category(id: '', name: 'All'),
          isSelected: categoryId == selectedCategoryId,
          onTap: () => onCategorySelected(categoryId),
        );
      },
    ),
  );
}
