import 'dart:math';

import 'package:api_consumption/model/product_model.dart';
import 'package:api_consumption/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductDisplayPage extends StatefulWidget {
  const ProductDisplayPage({super.key});

  @override
  State<ProductDisplayPage> createState() => _ProductDisplayPageState();
}

class _ProductDisplayPageState extends State<ProductDisplayPage> {
  List<Product> products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      List<Product> fetchedProducts = await ProductService().fetchProducts();
      if (mounted) {
        setState(() {
          products = fetchedProducts;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
        content: Text('Something went wrong, please try again'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          top: kToolbarHeight + 16.0,
          left: 16.0,
          right: 16.0,
        ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Page')),
      body: SingleChildScrollView(
        child: Column(
          children: products.map((product) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].withValues(alpha: 0.5),
                  child: Text(product.id.toString()),
                ),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

