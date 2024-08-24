import 'package:admin_app/data/data_models/ProductDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsDataSource {
  ///old method to get data from the API
  //  Future<bool> getProducts() async {
  //   try {
  //     print('getProducts called');
  //
  //     ///first: use http package to get data from the API (https://fakestoreapi.com/procts)
  //     final response =
  //         await http.get(Uri.parse('https://dummyjson.com/products'));
  //
  //     ///second: check if the response is successful
  //     if (response.statusCode == 200) {
  //       /// decode the response body from JSON to List<dynamic>
  //       Map<String, dynamic> responseBody = jsonDecode(response.body);
  //
  //       final List<dynamic> productsList = responseBody['products'];
  //
  //       for (Map<String, dynamic> item in productsList) {
  //         ///first: create a new instance of ProductDataModel
  //         ///and pass the required parameters from the map item
  //         /// in list which get it from the API after decoding the response body
  //         ProductDataModel product = ProductDataModel.fromJson(item);
  //
  //         ///second: add the product to the items list
  //         items.add(product);
  //       }
  //
  //       ///third: update the UI
  //       isLoading = false;
  //     } else {
  //       throw Exception('${response.statusCode}');
  //     }
  //     return true;
  //   } catch (e) {
  //     /// if status code is not 200, or any other error occurred
  //     /// the thrown exception will be caught here
  //     /// and implement the error handling logic
  //     print(e);
  //     isLoading = false;
  //     isError = true;
  //     errorMessage = e.toString();
  //     return false;
  //   }
  // }

  Future<List<ProductDataModel>?> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> collection =
          await FirebaseFirestore.instance.collection('products').get();

      final List<Map<String, dynamic>> productsList = collection.docs.map((e) {
        return e.data();
      }).toList();

      List<ProductDataModel> items = [];

      for (Map<String, dynamic> item in productsList) {
        ///first: create a new instance of ProductDataModel
        ///and pass the required parameters from the map item
        /// in list which get it from the API after decoding the response body
        ProductDataModel product = ProductDataModel.fromJson(item);

        ///second: add the product to the items list
        items.add(product);
      }

      return items;
    } catch (e) {
      /// if status code is not 200, or any other error occurred
      /// the thrown exception will be caught here
      /// and implement the error handling logic
      print(e);

      return null;
    }
  }
}
