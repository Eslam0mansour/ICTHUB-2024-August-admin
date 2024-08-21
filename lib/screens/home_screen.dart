import 'package:admin_app/data/products_data_source.dart';
import 'package:admin_app/widgets/error_widget.dart';
import 'package:admin_app/widgets/loading_widget.dart';
import 'package:admin_app/widgets/products_list_widget.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    print('initState');

    if (ProductsDataSource.items.isEmpty) {
      ProductsDataSource.getProducts().then(
        (value) {
          setState(() {
            print('setState');
          });
        },
      );
    } else {
      print('data is already loaded before');
    }
  }

  @override
  void dispose() {
    print('Home Screen was disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
      ),
      body: ProductsDataSource.isLoading
          ? const LoadingWidget()
          : ProductsDataSource.isError
              ? AppErrorWidget(
                  errorMessage: ProductsDataSource.errorMessage,
                  onTryAgain: () async {
                    ProductsDataSource.items.clear();
                    ProductsDataSource.isLoading = true;
                    ProductsDataSource.isError = false;
                    setState(() {});
                    await ProductsDataSource.getProducts();
                  },
                )
              : Center(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      ProductsDataSource.items.clear();
                      ProductsDataSource.isLoading = true;
                      setState(() {});
                      await ProductsDataSource.getProducts();
                      setState(() {});
                    },
                    child: const ProductsListView(),
                  ),
                ),
    );
  }
}

/// bool ? true : false
///
/// if (bool) {
///  return true;
///  } else {
///  return false;
///  }
