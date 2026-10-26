import 'package:ecommerce_app_huma_volve/core/deep_link/product_share_service.dart';
import 'package:ecommerce_app_huma_volve/core/di/di.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/product.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecase/get_product_by_id_usecase.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/theme.dart';
import '../../../core/widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;
  final String? productId;

  const ProductDetailsScreen({super.key, required Product this.product})
    : productId = null;

  const ProductDetailsScreen.fromId({super.key, required String this.productId})
    : product = null;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Product? _product;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    if (_product == null) _loadProduct();
  }

  Future<void> _loadProduct() async {
    final id = widget.productId;
    if (id == null) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final result = await getIt<GetProductByIdUseCase>().call(id);
      if (!mounted) return;
      if (result.isSuccess && result.getData() != null) {
        setState(() => _product = result.getData());
      } else {
        setState(
          () => _errorMessage = result.isError
              ? result.errorMessage
              : 'Product not found',
        );
      }
    } catch (error) {
      if (mounted) setState(() => _errorMessage = error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    if (product == null) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: AppTheme.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_errorMessage ?? 'Product not found'),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _loadProduct,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
        ),
      );
    }
    final images =
        product.images?.where((image) => image.trim().isNotEmpty).toList() ??
        const <String>[];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppTheme.background,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                tooltip: 'Share on WhatsApp',
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, size: 18),
                ),
                onPressed: () =>
                    ProductShareService.shareProduct(context, product),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: images.isEmpty
                  ? const Center(
                      child: Icon(Icons.image_not_supported, size: 56),
                    )
                  : PageView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final image = Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(Icons.image_not_supported, size: 56),
                          ),
                        );
                        return index == 0
                            ? Hero(tag: 'product-${product.id}', child: image)
                            : image;
                      },
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              transform: Matrix4.translationValues(0.0, -32.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title?.isNotEmpty == true
                                ? product.title!
                                : 'Untitled product',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(fontSize: 28, height: 1.2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${(product.price ?? 0).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: AppTheme.primary, fontSize: 24),
                        ),
                      ],
                    ),
                    if (product.categoryName?.isNotEmpty == true) ...[
                      Text(
                        product.categoryName!,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    const SizedBox(height: 24),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description?.isNotEmpty == true
                          ? product.description!
                          : 'No description available.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      text: 'Add to Cart',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.title ?? 'Product'} added to cart',
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
