import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../global_bloc/blocs.dart';
import './components/body.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>.value(
      value: context.read<ProductsBloc>()..add(FetchProductFromLocal()),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo.png",
            height: 80,
            fit: BoxFit.fitHeight,
          ),
          centerTitle: true,
        ),
        body: const Body(),
      ),
    );
  }
}
