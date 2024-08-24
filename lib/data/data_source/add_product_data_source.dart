import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsDataSource {
  static bool isLoading = false;
  static bool isError = false;
  static String errorMessage = '';

  static File? image;

  static Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
    }
  }

  static Future<bool> addProduct({
    required String title,
    required String description,
    required double price,
  }) async {
    try {
      isLoading = true;
      final imageUrl = await _uploadImage(title: title);

      await FirebaseFirestore.instance.collection('products').add({
        'title': title,
        'description': description,
        'price': price,
        'thumbnail': imageUrl,
      });
      isLoading = false;
      return true;
    } catch (e) {
      isLoading = false;
      isError = true;
      errorMessage = e.toString();
      print(e);
      return false;
    }
  }

  static Future<String> _uploadImage({
    required String title,
  }) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('productsImages')
        .child('$title.jpg');

    await ref.putFile(image!);

    final url = await ref.getDownloadURL();

    return url;
  }
}
