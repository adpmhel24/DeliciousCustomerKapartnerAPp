import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart'
    as animated_dialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kapartner_app/data/models/models.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/presentation/widget/oval_button.dart';
import 'package:kapartner_app/router/router.gr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../utils/currency_formater.dart';

import '../../../widget/constant.dart';
import '../../../widget/custom_text_field.dart';
import '../bloc/bloc.dart';

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
  final CustomerInfoRepo _custInfoRepo = AppRepo.customerInfoRepo;
  late String _deliveryMethodSelected = "";
  late String _paymentMethodSelected = "";
  late CustomerAddressModel? _selectedAddress;

  @override
  void initState() {
    _selectedAddress = _custInfoRepo.defautShippingAddress();

    context
        .read<CheckoutFormBloc>()
        .add(CustCodeChanged(_custInfoRepo.customer.code));
    context
        .read<CheckoutFormBloc>()
        .add(ContactNumberChanged(_custInfoRepo.customer.contactNumber ?? ""));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _deliveryDateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> deliveryMethods = [
    {"name": "Delivery", "value": "Delivery"},
    {"name": "Pickup", "value": "Pickup"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"name": "Cash On Delivery", "value": "Cash On Delivery"},
    {"name": "PayMaya", "value": "PayMaya"},
    {"name": "GCash", "value": "GCash"},
    {"name": "BDO", "value": "BDO"},
  ];

  Future pickImage(source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image == null) return;
      final imageTemp = File(image.path);

      context.read<CheckoutFormBloc>().add(AttachmentFileAdded(imageTemp));
    } on PlatformException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: BlocBuilder<CheckoutFormBloc, CheckoutFormState>(
            builder: (context, state) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customerInfo(context),
                    Constant.columnMaxHeightSpacer,
                    deliveryMethodField(context),
                    Constant.columnMaxHeightSpacer,
                    shippingPickupAddress(context),
                    Constant.columnMaxHeightSpacer,
                    paymentMethodField(context),
                    Constant.columnMaxHeightSpacer,
                    DeliveryDateField(
                      controller: _deliveryDateController,
                      dateFormat: dateFormat,
                    ),
                    Constant.columnMaxHeightSpacer,
                    CustomTextField(
                      labelText: "Notes",
                      controller: _notesController,
                      minLines: 3,
                      maxLines: 5,
                      onChanged: (_) {
                        context
                            .read<CheckoutFormBloc>()
                            .add(NotesChanged(_notesController.text));
                      },
                    ),
                    SizedBox(height: 15.h),
                    ColumnLabelInfo(
                      label: "Attachment",
                      child: Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (state.attachments.isNotEmpty)
                            ...state.attachments
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (e) => InkWell(
                                    onLongPress: () {
                                      CustomDialog.warning(
                                        context,
                                        title: const Text("Removing image"),
                                        message:
                                            "Are you sure you want to remove this image?",
                                        onPositiveClick: () {
                                          context.read<CheckoutFormBloc>().add(
                                                AttachmentRemoved(e.key),
                                              );
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                    onTap: () {
                                      AutoRouter.of(context).push(
                                        AttachmentViewerRoute(
                                          imageFile: e.value,
                                          onDelete: () {
                                            CustomDialog.warning(
                                              context,
                                              title:
                                                  const Text("Removing image"),
                                              message:
                                                  "Are you sure you want to remove this image?",
                                              onPositiveClick: () {
                                                context
                                                    .read<CheckoutFormBloc>()
                                                    .add(
                                                      AttachmentRemoved(e.key),
                                                    );
                                                Navigator.of(context)
                                                  ..pop()
                                                  ..pop();
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Hero(
                                        tag: e.value,
                                        child: Image.file(
                                          e.value,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Card(
                              elevation: 3,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  animated_dialog.showAnimatedDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text("Select Source"),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  pickImage(ImageSource.camera);
                                                },
                                                icon: const Icon(
                                                    Icons.camera_alt),
                                                label: const Text("Camera"),
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  pickImage(
                                                      ImageSource.gallery);
                                                },
                                                icon: const Icon(Icons.folder),
                                                label: const Text("Gallery"),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.items.length,
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
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.items[index].itemName,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Constant.columnMinHeightSpacer,
                                          Wrap(
                                            spacing: 5,
                                            children: [
                                              const Text(
                                                "Quantity:",
                                                style: TextStyle(
                                                  color:
                                                      Constant.inlineLabelColor,
                                                ),
                                              ),
                                              Text(
                                                formatStringToDecimal(state
                                                    .items[index].quantity
                                                    .toString()),
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            spacing: 5,
                                            children: [
                                              const Text(
                                                "Price:",
                                                style: TextStyle(
                                                  color:
                                                      Constant.inlineLabelColor,
                                                ),
                                              ),
                                              Text(
                                                formatStringToDecimal(state
                                                    .items[index].price
                                                    .toString()),
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            spacing: 5,
                                            children: [
                                              const Text(
                                                "Discount %:",
                                                style: TextStyle(
                                                  color:
                                                      Constant.inlineLabelColor,
                                                ),
                                              ),
                                              Text(
                                                "${formatStringToDecimal(state.items[index].discprcnt.toString())}%",
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            spacing: 5,
                                            children: [
                                              const Text(
                                                "Disc Amount:",
                                                style: TextStyle(
                                                  color:
                                                      Constant.inlineLabelColor,
                                                ),
                                              ),
                                              Text(
                                                formatStringToDecimal(
                                                  state.items[index].discAmount
                                                      .toString(),
                                                  hasCurrency: true,
                                                ),
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        formatStringToDecimal(
                                            state.items[index].total.toString(),
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
                      ),
                    ),
                  ]);
            },
          ),
        ),
      ),
    );
  }

  SizedBox shippingPickupAddress(BuildContext context) {
    return SizedBox(
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
                    RichText(
                      text: TextSpan(
                        text: "Shipping / Pickup Address: ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(
                              text: '*', style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      context.watch<CheckoutFormBloc>().state.address.value,
                    )
                  ],
                ),
              ),
              OvalButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    AddressSelectionScreenRoute(
                      checkoutBloc: context.read<CheckoutFormBloc>(),
                      onSelected: (customerAddress) {
                        _selectedAddress = customerAddress;
                      },
                      deliveryMethod: _deliveryMethodSelected,
                    ),
                  );
                },
                child: const Text('Change'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox customerInfo(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              Wrap(
                children: [
                  const Text(
                    "Full Name:",
                    style: TextStyle(color: Constant.inlineLabelColor),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _custInfoRepo.customer.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Wrap(
                children: [
                  const Text(
                    "Contact #:",
                    style: TextStyle(color: Constant.inlineLabelColor),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _custInfoRepo.customer.contactNumber ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Wrap(
                children: [
                  const Text(
                    "Email:",
                    style: TextStyle(color: Constant.inlineLabelColor),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _custInfoRepo.customer.email ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox paymentMethodField(BuildContext context) {
    return SizedBox(
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
                    RichText(
                      text: TextSpan(
                        text: "Payment: ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(
                              text: '*', style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder<CheckoutFormBloc, CheckoutFormState>(
                      buildWhen: (prev, curr) =>
                          prev.paymentMethod != curr.paymentMethod,
                      builder: (context, state) {
                        return Text(
                          state.paymentMethod.value,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    )
                  ],
                ),
              ),
              Flexible(
                child: OvalButton(
                  child: const Text("Select"),
                  onPressed: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          topRight: Radius.circular(10.r),
                        ),
                      ),
                      builder: (_) {
                        return SafeArea(
                          child: SizedBox(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: paymentMethods.length,
                              separatorBuilder: (_, index) {
                                return const Divider(
                                  thickness: 1,
                                  color: Color(0xFFBDBDBD),
                                );
                              },
                              itemBuilder: (_, index) {
                                return ListTile(
                                  title: Text(
                                    paymentMethods[index]["name"],
                                  ),
                                  selected: _paymentMethodSelected ==
                                      paymentMethods[index]["name"],
                                  selectedColor: Constant.onSelectedColor,
                                  onTap: () {
                                    _paymentMethodSelected =
                                        paymentMethods[index]["name"];
                                    context.read<CheckoutFormBloc>().add(
                                          PaymentMethodChange(
                                              paymentMethods[index]["name"]),
                                        );
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox deliveryMethodField(BuildContext context) {
    return SizedBox(
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
                    RichText(
                      text: TextSpan(
                        text: "Pickup / Delivery: ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(
                              text: '*', style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BlocBuilder<CheckoutFormBloc, CheckoutFormState>(
                      buildWhen: (prev, curr) =>
                          prev.deliveryMethod != curr.deliveryMethod,
                      builder: (context, state) {
                        return Text(
                          state.deliveryMethod.value,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    )
                  ],
                ),
              ),
              Flexible(
                  child: OvalButton(
                child: const Text("Select"),
                onPressed: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                    ),
                    builder: (_) {
                      return SafeArea(
                        child: SizedBox(
                          // height: (SizeConfig.screenHeight * .75).h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: deliveryMethods.length,
                            separatorBuilder: (_, index) {
                              return const Divider(
                                thickness: 1,
                                color: Color(0xFFBDBDBD),
                              );
                            },
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(
                                  deliveryMethods[index]["name"],
                                ),
                                selected: _deliveryMethodSelected ==
                                    deliveryMethods[index]["name"],
                                selectedColor: Constant.onSelectedColor,
                                onTap: () {
                                  _deliveryMethodSelected =
                                      deliveryMethods[index]["name"];

                                  if (_deliveryMethodSelected == 'Delivery' &&
                                      _selectedAddress != null) {
                                    context.read<CheckoutFormBloc>().add(
                                          AddressChanged(_selectedAddress!),
                                        );
                                  }

                                  context.read<CheckoutFormBloc>().add(
                                        DeliveryMethodChanged(
                                          deliveryMethods[index]["name"],
                                        ),
                                      );
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
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
          minTime: DateTime.now(),
          maxTime: DateTime(2100, 12, 31),
          onConfirm: (date) {
            _controller.text = _dateFormat.format(date);
            context
                .read<CheckoutFormBloc>()
                .add(DeliveryDateChanged(date.toIso8601String()));
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

class ColumnLabelInfo extends StatelessWidget {
  const ColumnLabelInfo({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Constant.inlineLabelColor,
          ),
        ),
        child,
      ],
    );
  }
}
