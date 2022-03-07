import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapartner_app/presentation/utils/currency_formater.dart';
import 'package:kapartner_app/data/repositories/cart_items_repo.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/router/router.gr.dart';

import '../../../../../global_bloc/blocs.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItemsRepo _cartItemRepo = CartItemsRepo();
    return BlocProvider<CartBloc>.value(
      value: context.read<CartBloc>()..add(GetAllCartItems()),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Shopping Cart'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: (_cartItemRepo.cartItems.isNotEmpty)
                      ? () {
                          CustomDialog.warning(context,
                              message:
                                  "Are you sure you want to remove all item?",
                              onNegativeClick: () {
                            Navigator.of(context).pop();
                          }, onPositiveClick: () {
                            context.read<CartBloc>().add(ClearCart());
                            Navigator.of(context).pop();
                          });
                        }
                      : null,
                  icon: Badge(
                    badgeContent: Text(
                      _cartItemRepo.cartItems.length.toString(),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
            body: const Body(),
            bottomNavigationBar: Container(
              height: 80,
              color: const Color(0xFFF7ECDE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      "Total: ${formatStringToDecimal(_cartItemRepo.totalCart.toString(), hasCurrency: true)}"),
                  ElevatedButton(
                    onPressed: (_cartItemRepo.cartItems.isNotEmpty)
                        ? () {
                            AutoRouter.of(context)
                                .push(const CheckOutScreenRoute());
                          }
                        : null,
                    child: const Text("Checkout"),
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
