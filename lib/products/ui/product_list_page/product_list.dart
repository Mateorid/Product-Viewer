import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/product_bloc.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/ui/product_detail_page/product_detail_page.dart';
import 'package:product_viewer/products/ui/product_list_page/product_tile.dart';
import 'package:product_viewer/util/shared_constants.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;
  final bool hasReachedMax;

  const ProductList({
    super.key,
    required this.products,
    required this.hasReachedMax,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return const Center(child: Text('No products to display'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSmallGap),
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<ProductBloc>().add(ProductFetched()),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: widget.hasReachedMax
              ? widget.products.length
              : widget.products.length + 1,
          itemBuilder: (context, index) {
            return index >= widget.products.length
                ? _lastItemLoadingIndicator()
                : _buildProductTile(widget.products[index], context);
          },
          separatorBuilder: (_, __) =>
              const SizedBox.square(dimension: kNormalGap),
        ),
      ),
    );
  }

  ProductTile _buildProductTile(Product product, BuildContext context) {
    return ProductTile(
      product: product,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailPage(
            product: product,
          ),
        ),
      ),
    );
  }

  Widget _lastItemLoadingIndicator() {
    return const Center(
      child: SizedBox(
        height: kLargeGap,
        width: kLargeGap,
        child: CircularProgressIndicator(strokeWidth: 2.0),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  /// Request more data when we reach the bottom of all loaded
  void _onScroll() {
    print('bottom: $_isBottom');
    if (_isBottom) context.read<ProductBloc>().add(ProductFetched());
  }

  /// Checks if we're in the bottom 10% of our list
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
