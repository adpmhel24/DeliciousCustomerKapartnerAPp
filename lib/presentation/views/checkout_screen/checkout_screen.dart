import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/data/models/checkout/checkout_model.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';
import 'package:kapartner_app/global_bloc/order_bloc/bloc.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/router/router.gr.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
            context.loaderOverlay.show();
          } else if (state is PlaceNewOrderFailure) {
            CustomDialog.error(context, message: state.message);
          } else if (state is PlaceNewOrderSucess) {
            context.loaderOverlay.hide();
            AutoRouter.of(context).replaceAll(
              [OrderSuccessScreenRoute(message: state.message)],
            );
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.red, //change your color here
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 5,
                          children: [
                            const Text(
                              "Delivery Fee:",
                              style:
                                  TextStyle(color: Constant.inlineLabelColor),
                            ),
                            Text(formatStringToDecimal(
                                context
                                    .read<CheckoutFormBloc>()
                                    .state
                                    .delfee
                                    .value,
                                hasCurrency: true)),
                          ],
                        ),
                        Constant.columnMaxHeightSpacer,
                        Wrap(
                          spacing: 5,
                          children: [
                            const Text(
                              "Order Total:",
                              style: TextStyle(
                                  color: Constant.inlineLabelColor,
                                  fontSize: 18),
                            ),
                            Text(
                              formatStringToDecimal(
                                  (double.parse(context
                                              .read<CheckoutFormBloc>()
                                              .state
                                              .delfee
                                              .value) +
                                          context
                                              .read<CheckoutFormBloc>()
                                              .state
                                              .total)
                                      .toString(),
                                  hasCurrency: true),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                  "delfee": double.parse(
                                      checkoutBlocState.delfee.value),
                                  "delivery_date":
                                      checkoutBlocState.deliveryDate.value,
                                  "delivery_method":
                                      checkoutBlocState.deliveryMethod.value,
                                  "payment_method":
                                      checkoutBlocState.paymentMethod.value,
                                  "remarks": checkoutBlocState.notes.value,
                                  "rows": checkoutBlocState.items
                                      .map((e) => e.checkOutData())
                                      .toList(),
                                };
                                CheckOutModel checkoutModel =
                                    CheckOutModel.fromJson(data);
                                context.read<OrderBloc>().add(
                                      PlaceNewOrder(
                                        checkoutModel: checkoutModel,
                                        cartItemRepo: _cartItemRepo,
                                      ),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side:
                                    const BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                    )
                  ],
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
