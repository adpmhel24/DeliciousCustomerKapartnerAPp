import 'package:flutter/material.dart';
import './components/body.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 80,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
