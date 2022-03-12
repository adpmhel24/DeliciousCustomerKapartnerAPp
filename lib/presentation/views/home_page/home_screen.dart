import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapartner_app/data/repositories/cart_items_repo.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:line_icons/line_icons.dart';

import '../../../global_bloc/blocs.dart';
import '../../../router/router.gr.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (prev, current) =>
          current is AddToCartSubmissionComplete || current is AddToCartFailure,
      listener: (context, state) {
        if (state is AddToCartSubmissionComplete) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Successfully Added"),
                duration: Duration(seconds: 1),
              ),
            );
        } else if (state is AddToCartFailure) {
          CustomDialog.error(context, message: state.message);
        }
      },
      child: AutoTabsRouter(
        routes: const [
          ProductsScreenRoute(),
          CartScreenRoute(),
          OrdersScreenRoute(),
          ProfileScreenRoute()
        ],
        duration: const Duration(milliseconds: 400),
        builder: (context, child, animation) {
          final tabsRouter = context.tabsRouter;
          return Scaffold(
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Tap back again to leave'),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
            bottomNavigationBar: buildBottomNavigationBar(context, tabsRouter),
          );
        },
      ),
    );
  }
}

BottomNavigationBar buildBottomNavigationBar(
    BuildContext context, TabsRouter tabsRouter) {
  final CartItemsRepo _cartItemRepo = CartItemsRepo();
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.red,
    onTap: (index) {
      if (index == 1) {
        context.read<CartBloc>().add(GetAllCartItems());
      }
      tabsRouter.setActiveIndex(index);
    },
    currentIndex: tabsRouter.activeIndex,
    items: [
      const BottomNavigationBarItem(
          icon: Icon(
            LineIcons.tags,
          ),
          label: 'Products'),
      BottomNavigationBarItem(
          icon: Badge(
            badgeContent: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) => Text(
                "${_cartItemRepo.cartItems.length}",
              ),
            ),
            child: const Icon(
              Icons.shopping_cart,
            ),
          ),
          label: 'Cart'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_rounded), label: 'Orders'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );
}
