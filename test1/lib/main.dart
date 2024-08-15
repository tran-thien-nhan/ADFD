import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product.dart';
import 'create.dart';
import 'update.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mã_số_sinh_viên',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();
  String _sortOption = 'Giá tăng dần';

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  void _loadProducts({bool ascending = true}) async {
    final products =
        await DatabaseHelper().getProductsSortedByPrice(ascending: ascending);
    setState(() {
      _products = products;
      _filteredProducts = products;
    });
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.productName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm sản phẩm',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _sortOption,
              onChanged: (String? newValue) {
                setState(() {
                  _sortOption = newValue!;
                  bool ascending = _sortOption == 'Giá tăng dần';
                  _loadProducts(ascending: ascending);
                });
              },
              items: <String>['Giá tăng dần', 'Giá giảm dần']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text('Số lượng: ${product.quantity}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Giá: ${product.price}'),
                      // Bạn có thể thêm các thông tin khác ở đây nếu cần
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateProductPage(product: product)),
                    ).then((value) => _loadProducts());
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateProductPage()),
          ).then((value) => _loadProducts());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
