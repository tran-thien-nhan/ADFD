import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b3/providers/ProductProvider.dart';
import 'package:b3/models/Product.dart';
import 'package:uuid/uuid.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  bool _isAvailable = true;
  DateTime _releaseDate = DateTime.now();
  String _category = 'snack'; // Default category

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final productProvider =
          Provider.of<Productprovider>(context, listen: false);
      final uuid = Uuid();
      final newProduct = Product(
        id: uuid.v4(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        isAvailable: _isAvailable,
        category: _category,
        releaseDate: _releaseDate,
        image: _imageController.text,
      );
      productProvider.addProduct(newProduct);
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _releaseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _releaseDate) {
      setState(() {
        _releaseDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category'),
                  RadioListTile<String>(
                    title: const Text('Snack'),
                    value: 'snack',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Food'),
                    value: 'food',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Drink'),
                    value: 'drink',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = value!;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Available'),
                value: _isAvailable,
                onChanged: (bool value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),
              ListTile(
                title: const Text('Release Date'),
                subtitle: Text("${_releaseDate.toLocal()}".split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
