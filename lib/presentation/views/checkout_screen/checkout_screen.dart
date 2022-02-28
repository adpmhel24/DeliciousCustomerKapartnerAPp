import 'package:flutter/material.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';

import '../../utils/currency_formater.dart';
import 'components/body.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItemsRepo _cartItemRepo = AppRepo.cartRepo;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: const Body(),
      bottomNavigationBar: Container(
        height: 80,
        color: const Color(0xFFF7ECDE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                "Order Total: ${formatStringToDecimal(_cartItemRepo.totalCart.toString(), hasCurrency: true)}"),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Place Order"),
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
  }
}
