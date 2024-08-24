import 'package:admin_app/data/data_models/ProductDataModel.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final ProductDataModel product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ///image - title - description - price
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ''),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.network(product.thumbnail ?? ''),
          Text(product.title ?? ''),
          Text(product.description ?? ''),
          Text(product.price.toString() ?? ''),
        ],
      ),
    );
  }
}
