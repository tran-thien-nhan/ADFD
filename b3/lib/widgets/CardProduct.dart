import 'dart:async';
import 'package:b3/screens/ProductUpdateForm.dart';
import 'package:flutter/material.dart';
import 'package:b3/models/Product.dart';
import 'package:provider/provider.dart';
import 'package:b3/providers/ProductProvider.dart'; // Đảm bảo import đúng Productprovider của bạn

class CardProduct extends StatelessWidget {
  final Product product;

  const CardProduct({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Text(
              'Available: ${product.isAvailable ? 'Yes' : 'No'}',
              style: TextStyle(
                fontSize: 16,
                color: product.isAvailable ? Colors.green : Colors.red,
              ),
            ),
            Text(
              'Category: ${product.category}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Release Date: ${product.releaseDate.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductUpdateForm(product: product)));
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 10), // Khoảng cách giữa hai nút
                ElevatedButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            padding: const EdgeInsets.all(20),
                            color: Colors.white,
                            child: Material(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Added to Cart',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Product has been added to your cart.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: widget,
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.shop),
                ),
                const SizedBox(width: 10), // Khoảng cách giữa hai nút
                ElevatedButton(
                  onPressed: () {
                    final productProvider =
                        Provider.of<Productprovider>(context, listen: false);
                    productProvider.deleteProduct(product.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Product has been deleted successfully.'),
                      ),
                    );
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
