import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/data/models/checkout/checkout_model.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';
import 'package:kapartner_app/global_bloc/order_bloc/bloc.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/router/router.gr.dart';

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
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is PlaceNewOrderInProgress) {
            CustomDialog.loading(context);
          } else if (state is PlaceNewOrderFailure) {
            CustomDialog.error(context, message: state.message);
          } else if (state is PlaceNewOrderSucess) {
            AutoRouter.of(context).replaceAll(
              [OrderSuccessScreenRoute(message: state.message)],
            );
          }
        },
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
                        ? () {
                            CustomDialog.warning(context,
                                message: "Are you sure you want to proceed?",
                                onPositiveClick: () {
                              var checkoutBlocState =
                                  context.read<CheckoutFormBloc>().state;

                              Map<String, dynamic> data = {
                                "cust_code": checkoutBlocState.custCode.value,
                                "address": checkoutBlocState.address.value,
                                "contact_number":
                                    checkoutBlocState.contactNumber.value,
                                "delivery_date":
                                    checkoutBlocState.deliveryDate.value,
                                "delivery_method":
                                    checkoutBlocState.deliveryMethod.value,
                                "payment_method":
                                    checkoutBlocState.paymentMethod.value,
                                "remarks": checkoutBlocState.notes.value,
                                "rows": _cartItemRepo.cartItems
                                    .map((e) => e.checkOutData())
                                    .toList(),
                              };
                              CheckOutModel checkoutModel =
                                  CheckOutModel.fromJson(data);
                              context.read<OrderBloc>().add(
                                    PlaceNewOrder(
                                        checkoutModel: checkoutModel,
                                        cartItemRepo: _cartItemRepo),
                                  );

                              Navigator.of(context).pop();
                            });
                          }
                        : null,
                    child: const Text("Place Order"),
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
            );
          }),
        ),
      ),
    );
  }
}
