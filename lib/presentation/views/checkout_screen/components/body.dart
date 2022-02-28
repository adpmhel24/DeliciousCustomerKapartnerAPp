import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kapartner_app/data/repositories/app_repo.dart';
import 'package:kapartner_app/data/repositories/customer_info_repo.dart';

import '../../../../data/models/models.dart';
import '../../../../global_bloc/blocs.dart';
import '../../../utils/currency_formater.dart';

import '../../../widget/custom_text_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  void initState() {
    _deliveryDateController.text = dateFormat.format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _deliveryDateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomerInfoRepo _custInfoRepo = AppRepo.customerInfoRepo;
    CustomerAddressModel? _custAddress = _custInfoRepo.defautShippingAddress();
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer Information: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Full Name:  ${_custInfoRepo.customer.name}",
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Contact #:  ${_custInfoRepo.customer.contactNumber ?? ''}",
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Email:  ${_custInfoRepo.customer.email ?? ''}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFCEAB93)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 180, 154, 153),
                                      ),
                                    ),
                                  ),
                                ),
                            onPressed: () {},
                            child: const Text("Change"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shipping Address: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "${_custAddress!.streetAddress!} ${_custAddress.brgy!} ${_custAddress.cityMunicipality!}",
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFCEAB93)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 180, 154, 153),
                                      ),
                                    ),
                                  ),
                                ),
                            onPressed: () {},
                            child: const Text("Change"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pickup / Delivery: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text(
                                "Pickup",
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFCEAB93)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 180, 154, 153),
                                      ),
                                    ),
                                  ),
                                ),
                            onPressed: () {},
                            child: const Text("Change"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text(
                                "Cash On Delivery",
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFCEAB93)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 180, 154, 153),
                                      ),
                                    ),
                                  ),
                                ),
                            onPressed: () {},
                            child: const Text("Change"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              DeliveryDateField(
                controller: _deliveryDateController,
                dateFormat: dateFormat,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                labelText: "Notes",
                controller: _notesController,
                minLines: 3,
                maxLines: 5,
              ),
              SizedBox(height: 15.h),
              Text(
                "Order Summary",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
              ),
              const Divider(thickness: 3),
              Flexible(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartItemsLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cartItems.length,
                        itemBuilder: (_, index) {
                          return Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 8.w),
                              child: LayoutBuilder(builder: (_, constraints) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * .45,
                                      child: Text(
                                        state.cartItems[index].itemName,
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Qty: ${state.cartItems[index].quantity}",
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        formatStringToDecimal(
                                            state.cartItems[index].total
                                                .toString(),
                                            hasCurrency: true),
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryDateField extends StatelessWidget {
  final TextEditingController _controller;
  final DateFormat _dateFormat;
  final Widget? _suffixIcon;

  const DeliveryDateField({
    Key? key,
    required TextEditingController controller,
    required DateFormat dateFormat,
    Widget? suffixIcon,
  })  : _controller = controller,
        _dateFormat = dateFormat,
        _suffixIcon = suffixIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      controller: _controller,
      labelText: 'Delivery Date*',
      readOnly: true,
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2018, 3, 5),
          maxTime: DateTime(2100, 12, 31),
          onConfirm: (date) {
            _controller.text = _dateFormat.format(date);
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      prefixIcon: const Icon(Icons.calendar_today),
      suffixIcon: _suffixIcon,
    );
  }
}
