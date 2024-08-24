import 'package:admin_app/cubits/products_cubit/cubit.dart';
import 'package:admin_app/cubits/products_cubit/states.dart';
import 'package:admin_app/ui/widgets/error_widget.dart';
import 'package:admin_app/ui/widgets/loading_widget.dart';
import 'package:admin_app/ui/widgets/products_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const LoadingWidget();
          } else if (state is ProductsError) {
            return AppErrorWidget(
              errorMessage: state.message,
            );
          } else if (state is ProductsLoaded) {
            return Center(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ProductsListView(
                  products: state.products,
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('UNknown Error'),
            );
          }
        },
      ),

      ///old body without cubit
      // body: ProductsDataSource.isLoading
      //     ? const LoadingWidget()
      //     : ProductsDataSource.isError
      //         ? AppErrorWidget(
      //             errorMessage: ProductsDataSource.errorMessage,
      //             onTryAgain: () async {
      //               ProductsDataSource.items.clear();
      //               ProductsDataSource.isLoading = true;
      //               ProductsDataSource.isError = false;
      //               setState(() {});
      //               await ProductsDataSource.getProducts();
      //             },
      //           )
      //         : Center(
      //             child: RefreshIndicator(
      //               onRefresh: () async {
      //                 ProductsDataSource.items.clear();
      //                 ProductsDataSource.isLoading = true;
      //                 setState(() {});
      //                 await ProductsDataSource.getProducts();
      //                 setState(() {});
      //               },
      //               child: const ProductsListView(),
      //             ),
      //           ),
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
