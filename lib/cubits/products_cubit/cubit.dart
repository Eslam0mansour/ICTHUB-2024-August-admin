import 'package:admin_app/cubits/products_cubit/states.dart';
import 'package:admin_app/data/data_source/products_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());

  ProductsDataSource dataSource = ProductsDataSource();

  void getProducts() async {
    try {
      final products = await dataSource.getProducts();
      if (products != null) {
        emit(ProductsLoaded(products));
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
