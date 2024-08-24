import 'package:admin_app/data/data_models/ProductDataModel.dart';
import 'package:admin_app/ui/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  final List<ProductDataModel> products;
  const ProductsListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    product: products[index],
                  ),
                ),
                (route) => false,
              );
            },
            tileColor: Colors.grey[200],
            leading: Image.network(
              products[index].thumbnail ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            title: Text(
              products[index].title ?? '',
              maxLines: 2,
            ),
            subtitle: Text(
              products[index].description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              '${products[index].price} \$',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
