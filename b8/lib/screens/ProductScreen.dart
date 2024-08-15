import 'package:b8/providers/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              if (productProvider.products.length > 0) {
                return GestureDetector(
                  onLongPress: () {},
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Wrap(
                          children: [
                            Text("Name: ${product.name}"),
                            Text("Cate: ${product.category}"),
                            Text(
                                "Available: ${product.isAvailable ? "Yes" : "No"}"),
                            Text("Con: ${product.condition}")
                          ],
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text("No products available"));
              }
            }),
      ),
    );
  }
}
