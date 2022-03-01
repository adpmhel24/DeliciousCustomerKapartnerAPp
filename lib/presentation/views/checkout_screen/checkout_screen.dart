import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';

import '../../utils/currency_formater.dart';
import 'bloc/bloc.dart';
import 'components/body.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItemsRepo _cartItemRepo = AppRepo.cartRepo;
    return BlocProvider(
      create: (_) => CheckoutFormBloc(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text("Checkout"),
          centerTitle: true,
        ),
        body: const Body(),
        bottomNavigationBar: Builder(builder: (context) {
          return Container(
            height: 80,
            color: const Color(0xFFF7ECDE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    "Order Total: ${formatStringToDecimal(_cartItemRepo.totalCart.toString(), hasCurrency: true)}"),
                ElevatedButton(
                  onPressed: (context
                          .watch<CheckoutFormBloc>()
                          .state
                          .status
                          .isValidated)
                      ? () {}
                      : null,
                  child: const Text("Place Order"),
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
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
          );
        }),
      ),
    );
  }
}
