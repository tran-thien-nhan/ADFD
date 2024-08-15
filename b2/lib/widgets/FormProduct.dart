import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormProduct extends StatefulWidget {
  const FormProduct({super.key});

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _products = [];
  final List<Map<String, dynamic>> _filteredProducts = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _sortColumn = 'name';
  bool _sortAscending = true;

  Map<String, dynamic>? _editingProduct;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts.clear();
      _filteredProducts.addAll(_products.where((product) {
        return product['name'].toLowerCase().contains(query) ||
            product['price'].toString().contains(query) ||
            product['quantity'].toString().contains(query);
      }));
    });
  }

  void _sortProducts(String column) {
    setState(() {
      if (_sortColumn == column) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumn = column;
        _sortAscending = true;
      }
      _filteredProducts.sort((a, b) {
        if (_sortAscending) {
          return a[column].compareTo(b[column]);
        } else {
          return b[column].compareTo(a[column]);
        }
      });
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        final newProduct = {
          'name': _nameController.text,
          'price': double.parse(_priceController.text),
          'quantity': int.parse(_quantityController.text),
        };

        if (_editingProduct != null) {
          // Update existing product
          _editingProduct!['name'] = newProduct['name'];
          _editingProduct!['price'] = newProduct['price'];
          _editingProduct!['quantity'] = newProduct['quantity'];
        } else {
          // Add new product
          _products.add(newProduct);
          _filteredProducts.add(newProduct);
        }

        _filterProducts();
        _editingProduct = null;
      });

      _nameController.clear();
      _priceController.clear();
      _quantityController.clear();
    }
  }

  void _deleteProduct(Map<String, dynamic> product) {
    setState(() {
      _products.remove(product);
      _filteredProducts.remove(product);
      _filterProducts();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product deleted successfully'),
      ),
    );
  }

  void _editProduct(Map<String, dynamic> product) {
    setState(() {
      _editingProduct = product;
      _nameController.text = product['name'];
      _priceController.text = product['price'].toString();
      _quantityController.text = product['quantity'].toString();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }

                  if (value.length < 2 || value.length > 10) {
                    return 'Product name should be between 2 and 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: 'Product Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Product price should be greater than 0';
                  }

                  if (double.parse(value) > 1000) {
                    return 'Product price should be less than or equal to 1000';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Product Quantity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product quantity';
                  }

                  if (int.parse(value) <= 0) {
                    return 'Product quantity should be greater than 0';
                  }

                  if (int.parse(value) > 1000) {
                    return 'Product quantity should be less than or equal to 1000';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 10,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    columns: [
                      DataColumn(
                        label: const Text(
                          'Name',
                          style: TextStyle(color: Colors.pink),
                        ),
                        onSort: (columnIndex, _) {
                          _sortProducts('name');
                        },
                      ),
                      DataColumn(
                        label: const Text(
                          'Price',
                          style: TextStyle(color: Colors.pink),
                        ),
                        onSort: (columnIndex, _) {
                          _sortProducts('price');
                        },
                      ),
                      DataColumn(
                        label: const Text(
                          'Quantity',
                          style: TextStyle(color: Colors.pink),
                        ),
                        onSort: (columnIndex, _) {
                          _sortProducts('quantity');
                        },
                      ),
                      DataColumn(
                        label: const Text(
                          'Actions',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                      DataColumn(
                        label: const Text(
                          'Actions',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                    rows: _filteredProducts.map((product) {
                      return DataRow(cells: [
                        DataCell(Text(product['name'])),
                        DataCell(Text(product['price'].toString())),
                        DataCell(Text(product['quantity'].toString())),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteProduct(product);
                            },
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.red),
                            onPressed: () {
                              _editProduct(product);
                            },
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
