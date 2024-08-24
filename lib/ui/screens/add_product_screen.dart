import 'package:admin_app/data/data_source/add_product_data_source.dart';
import 'package:admin_app/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await AddProductsDataSource.pickImageFromGallery();
                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 80,
                  child: AddProductsDataSource.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.file(
                            AddProductsDataSource.image!,
                            fit: BoxFit.contain,
                          ),
                        )
                      : const Icon(Icons.add_a_photo),
                ),
              ),
              CustomTextFormField(
                controller: _titleController,
                hintText: 'Product title',
                label: 'Title',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: _descriptionController,
                hintText: 'Product description',
                label: 'Description',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: _priceController,
                hintText: 'Product price',
                label: 'Price',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Price is required';
                  } else if (int.tryParse(value) == null) {
                    return 'Price must be a number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (AddProductsDataSource.image != null) {
                      setState(() {});
                      AddProductsDataSource.addProduct(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        price: double.parse(_priceController.text),
                      ).then((value) {
                        if (value) {
                          setState(() {
                            AddProductsDataSource.image = null;
                            _titleController.clear();
                            _descriptionController.clear();
                            _priceController.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Product added successfully'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(AddProductsDataSource.errorMessage),
                            ),
                          );
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please pick an image'),
                        ),
                      );
                      await Future.delayed(const Duration(seconds: 1), () {});

                      await AddProductsDataSource.pickImageFromGallery();
                      setState(() {});
                    }
                  }
                },
                child: AddProductsDataSource.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
