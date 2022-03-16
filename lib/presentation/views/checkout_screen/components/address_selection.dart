import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kapartner_app/data/models/models.dart';

import 'package:kapartner_app/data/repositories/repositories.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';
import 'package:kapartner_app/presentation/widget/oval_button.dart';

import '../../../widget/custom_label_info.dart';
import '../bloc/bloc.dart';

class AddressSelectionScreen extends StatelessWidget {
  const AddressSelectionScreen({
    Key? key,
    required this.checkoutBloc,
    required this.onSelected,
    required this.deliveryMethod,
  }) : super(key: key);

  final CheckoutFormBloc checkoutBloc;
  final void Function(CustomerAddressModel?) onSelected;
  final String deliveryMethod;

  @override
  Widget build(BuildContext context) {
    final CustomerInfoRepo _customerInfoRepo = AppRepo.customerInfoRepo;
    final HubRepo _hubRepo = AppRepo.hubRepository;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Select ${deliveryMethod == 'Delivery' ? 'Shipping' : 'Pickup'} Address"),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ListView.builder(
            itemCount: deliveryMethod == 'Delivery'
                ? _customerInfoRepo.customer.details.length
                : _hubRepo.hubs.length,
            itemBuilder: (_, indx) {
              return (deliveryMethod == 'Delivery')
                  ? Card(
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
                                child: Text(_customerInfoRepo.customer
                                        .details[indx]?.streetAddress ??
                                    ""),
                              ),
                              Constant.columnMinHeightSpacer,
                              LabelInfo(
                                label: "Baranggay",
                                child: Text(_customerInfoRepo
                                        .customer.details[indx]?.brgy ??
                                    ""),
                              ),
                              Constant.columnMinHeightSpacer,
                              LabelInfo(
                                label: "City / Municipality",
                                child: Text(_customerInfoRepo.customer
                                        .details[indx]?.cityMunicipality ??
                                    ""),
                              ),
                              Constant.columnMinHeightSpacer,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OvalButton(
                                    onPressed: () {
                                      onSelected(_customerInfoRepo
                                          .customer.details[indx]);
                                      checkoutBloc.add(
                                        AddressChanged(_customerInfoRepo
                                            .customer.details[indx]),
                                      );
                                      AutoRouter.of(context).pop();
                                    },
                                    child: const Text("Select"),
                                  ),
                                  if (_customerInfoRepo.customer.details[indx]
                                              ?.isDefault !=
                                          null &&
                                      _customerInfoRepo.customer.details[indx]
                                              ?.isDefault! ==
                                          true)
                                    const Text("Default Address"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Card(
                      elevation: 3,
                      child: SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelInfo(
                                label: "Hub",
                                child: Text(_hubRepo.hubs[indx].whsename),
                              ),
                              Constant.columnMinHeightSpacer,
                              LabelInfo(
                                label: "Street Address",
                                child: Text(_hubRepo.hubs[indx].address),
                              ),
                              OvalButton(
                                onPressed: () {
                                  onSelected(null);
                                  checkoutBloc.add(
                                    PickupAddressChanged(
                                        _hubRepo.hubs[indx].address),
                                  );
                                  AutoRouter.of(context).pop();
                                },
                                child: const Text("Select"),
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
