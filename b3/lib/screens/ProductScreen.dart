import 'package:b3/screens/ProductForm.dart';
import 'package:b3/widgets/CardProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b3/providers/ProductProvider.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> imgList = [
    'https://static.kfcvietnam.com.vn/images/content/home/carousel/lg/BO.jpg?v=46kPkg',
    'https://img.gotit.vn/compress/brand/images/1672318321_1JZy0.png',
    'https://media-cdn.tripadvisor.com/media/photo-s/1b/99/44/8e/kfc-faxafeni.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Productprovider>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        leading: Icon(Icons.help),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                        child: Image.network(item,
                            fit: BoxFit.cover, width: 1000, height: 300),
                      ),
                    ))
                .toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: CardProduct(product: productProvider.products[i]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProductForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
