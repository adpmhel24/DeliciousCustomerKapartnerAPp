import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kapartner_app/data/repositories/app_repo.dart';
import 'package:kapartner_app/data/repositories/customer_info_repo.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';
import 'package:kapartner_app/presentation/widget/oval_button.dart';

import '../../../widget/custom_label_info.dart';
import '../bloc/bloc.dart';

class AddressSelectionScreen extends StatelessWidget {
  const AddressSelectionScreen({
    Key? key,
    required this.checkoutBloc,
  }) : super(key: key);

  final CheckoutFormBloc checkoutBloc;

  @override
  Widget build(BuildContext context) {
    final CustomerInfoRepo _customerInfoRepo = AppRepo.customerInfoRepo;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Shipping Address"),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ListView.builder(
            itemCount: _customerInfoRepo.customer.details.length,
            itemBuilder: (_, indx) {
              return Card(
                elevation: 3,
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelInfo(
                          label: "Street Address",
                          child: Text(_customerInfoRepo
                                  .customer.details[indx]?.streetAddress ??
                              ""),
                        ),
                        Constant.columnMinHeightSpacer,
                        LabelInfo(
                          label: "Baranggay",
                          child: Text(
                              _customerInfoRepo.customer.details[indx]?.brgy ??
                                  ""),
                        ),
                        Constant.columnMinHeightSpacer,
                        LabelInfo(
                          label: "City / Municipality",
                          child: Text(_customerInfoRepo
                                  .customer.details[indx]?.cityMunicipality ??
                              ""),
                        ),
                        Constant.columnMinHeightSpacer,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OvalButton(
                              onPressed: () {
                                String address =
                                    "${_customerInfoRepo.customer.details[indx]?.streetAddress ?? ''} "
                                    "${_customerInfoRepo.customer.details[indx]?.brgy ?? ''} "
                                    "${_customerInfoRepo.customer.details[indx]?.cityMunicipality ?? ''}";
                                checkoutBloc.add(
                                  AddressChanged(
                                    address,
                                    _customerInfoRepo.customer.details[indx]
                                            ?.deliveryFee ??
                                        0.00,
                                  ),
                                );
                                AutoRouter.of(context).pop();
                              },
                              child: const Text("Select"),
                            ),
                            if (_customerInfoRepo
                                        .customer.details[indx]?.isDefault !=
                                    null &&
                                _customerInfoRepo
                                        .customer.details[indx]?.isDefault! ==
                                    true)
                              const Text("Default Address"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
