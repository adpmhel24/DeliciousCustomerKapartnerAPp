import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kapartner_app/data/models/models.dart';
import 'package:kapartner_app/presentation/utils/currency_formater.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../router/router.gr.dart';
import '../../../../../widget/constant.dart';
import '../../../../../widget/custom_dialog.dart' as c;
import '../for_dispatch_orders/bloc/bloc.dart';
import '../pending_orders/bloc/bloc.dart';
import 'add_attachment_bloc/bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
    required this.order,
    required this.orderTab,
    required this.bloc,
  }) : super(key: key);
  final OrderItemModel order;
  final String orderTab;
  final Bloc bloc;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderItemModel order;

  @override
  void initState() {
    order = widget.order;
    super.initState();
  }

  List<File> files = [];

  Future pickImage(
      {required void Function(File attachment) addToOrder,
      required source}) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image == null) return;
      final imageTemp = File(image.path);

      addToOrder(imageTemp);
      setState(() {
        files.add(imageTemp);
      });
    } on PlatformException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAttachmentToOrderBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<AddAttachmentToOrderBloc,
            AddAttachmentToOrderState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              order = state.order!;
              c.CustomDialog.success(
                context,
                message: "Successfully added!",
                onPositiveClick: () {
                  if (widget.orderTab.toLowerCase() == 'pending') {
                    widget.bloc.add(FetchPendingOrders());
                  } else {
                    widget.bloc.add(FetchForDispatchOrders());
                  }

                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
              );
            } else if (state.status.isSubmissionInProgress) {
              context.loaderOverlay.show();
            } else if (state.status.isSubmissionFailure) {
              c.CustomDialog.error(context, message: state.message);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Order Details'),
                iconTheme: const IconThemeData(
                  color: Colors.red, //change your color here
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order No ${order.id}",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                          ),
                          Text(
                            order.orderStatus == 0 && order.docstatus != 'N'
                                ? "Pending"
                                : order.orderStatus == 1 &&
                                        order.docstatus != 'N'
                                    ? "For Dispatch"
                                    : "Delivered",
                            style: const TextStyle(
                              color: Constant.inlineLabelColor,
                            ),
                          )
                        ],
                      ),
                      Text(
                        DateFormat('MM/dd/yyy').format(order.transdate),
                        style: const TextStyle(
                          color: Constant.inlineLabelColor,
                        ),
                      ),
                      Constant.columnMaxHeightSpacer,
                      ColumnLabelInfo(
                        label: "Delivery date",
                        child: Text(
                          DateFormat('MM/dd/yyy').format(order.deliveryDate),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Constant.columnMaxHeightSpacer,
                      ColumnLabelInfo(
                        label: "Pickup / Shipping Address",
                        child: Text(
                          order.address ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Constant.columnMaxHeightSpacer,
                      ColumnLabelInfo(
                        label: "Payment method",
                        child: Text(
                          order.paymentMethod ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Constant.columnMaxHeightSpacer,
                      ColumnLabelInfo(
                        label: "Attachments",
                        child: Wrap(
                          spacing: 5,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (order.attachments!.isNotEmpty)
                              ...order.attachments!
                                  .asMap()
                                  .entries
                                  .map<Widget>(
                                    (e) => InkWell(
                                      onTap: () {
                                        AutoRouter.of(context).push(
                                          ImageViewerRoute(
                                            attachments: order.attachments!,
                                            initialIndex: e.key,
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 3,
                                        child: Hero(
                                          tag: e.value,
                                          child: CachedNetworkImage(
                                            imageUrl: e.value['image_url'],
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            if (widget.orderTab.toLowerCase() != 'completed')
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
                                      addAttachmentModal(context);
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      Constant.columnMaxHeightSpacer,
                      ColumnLabelInfo(
                        label: "Notes",
                        child: Text(
                          order.customerNotes ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Constant.columnMaxHeightSpacer,
                      const Divider(
                        color: Constant.dividerColor,
                        thickness: 1,
                      ),
                      itemDetails(),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                color: const Color(0xFFF7ECDE),
                padding: const EdgeInsets.all(10),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item Total"),
                      Text(
                        formatStringToDecimal(
                          order.rows!
                              .map((e) => e['subtotal'])
                              .toList()
                              .reduce((a, b) => a + b)
                              .toString(),
                          hasCurrency: true,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Fee"),
                      Text(
                        formatStringToDecimal(
                          order.delfee.toString(),
                          hasCurrency: true,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Other Fee"),
                      Text(
                        formatStringToDecimal(
                          order.otherfee.toString(),
                          hasCurrency: true,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grand Total",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatStringToDecimal(
                          order.doctotal.toString(),
                          hasCurrency: true,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ]),
              ),
            );
          },
        );
      }),
    );
  }

  Future<Object?> addAttachmentModal(BuildContext context) {
    return showAnimatedDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<AddAttachmentToOrderBloc>(),
            child: Builder(builder: (context) {
              return BlocBuilder<AddAttachmentToOrderBloc,
                  AddAttachmentToOrderState>(
                builder: (context, state) {
                  return AlertDialog(
                    title: const Text("Add Attachment"),
                    content: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (state.attachments.isNotEmpty)
                          ...state.attachments
                              .asMap()
                              .entries
                              .map<Widget>(
                                (e) => InkWell(
                                  onTap: () {
                                    AutoRouter.of(context).push(
                                      AttachmentViewerRoute(
                                        imageFile: e.value,
                                        onDelete: () {
                                          c.CustomDialog.warning(
                                            context,
                                            title: const Text("Removing image"),
                                            message:
                                                "Are you sure you want to remove this image?",
                                            onPositiveClick: () {
                                              context
                                                  .read<
                                                      AddAttachmentToOrderBloc>()
                                                  .add(
                                                      AttachmentRemoved(e.key));
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
                                    elevation: 3,
                                    child: Hero(
                                      tag: e.value,
                                      child: Image.file(
                                        e.value,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
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
                              // onPressed: () => pickImage(

                              // ),
                              onPressed: () {
                                showAnimatedDialog(
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
                                                pickImage(
                                                    addToOrder: (attachment) =>
                                                        context
                                                            .read<
                                                                AddAttachmentToOrderBloc>()
                                                            .add(
                                                              AttachmentAdded(
                                                                  attachment),
                                                            ),
                                                    source: ImageSource.camera);
                                              },
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                              label: const Text("Camera"),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                pickImage(
                                                    addToOrder: (attachment) =>
                                                        context
                                                            .read<
                                                                AddAttachmentToOrderBloc>()
                                                            .add(
                                                              AttachmentAdded(
                                                                  attachment),
                                                            ),
                                                    source:
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
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.red[300]),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: state.status.isValid
                              ? () {
                                  c.CustomDialog.warning(
                                    context,
                                    message: "Are you sure you want to submit?",
                                    onPositiveClick: () {
                                      context
                                          .read<AddAttachmentToOrderBloc>()
                                          .add(
                                            AttachmentSubmitted(order.id!),
                                          );
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              : null,
                          child: const Text('Submit')),
                    ],
                  );
                },
              );
            }),
          );
        });
  }

  Flexible itemDetails() {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: order.rows?.length ?? 0,
        itemBuilder: (_, indx) {
          return ListTile(
            horizontalTitleGap: 15,
            contentPadding: EdgeInsets.zero,
            isThreeLine: true,
            leading: Text(
                "${order.rows?[indx]['quantity'].toString()} ${order.rows?[indx]['uom']}"),
            title: Text(
              order.rows?[indx]["item_code"] ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    const Text(
                      "Unit Price:",
                      style: TextStyle(color: Constant.inlineLabelColor),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      formatStringToDecimal(
                          order.rows![indx]["unit_price"].toString(),
                          hasCurrency: true),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      "Discount %:",
                      style: TextStyle(color: Constant.inlineLabelColor),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${formatStringToDecimal((order.rows?[indx]["discprcnt"] ?? 0.00).toString())}%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      "Discount Amnt:",
                      style: TextStyle(color: Constant.inlineLabelColor),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      formatStringToDecimal(
                        order.rows?[indx]["disc_amount"].toString() ?? "0.00",
                        hasCurrency: true,
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Text(formatStringToDecimal(
              order.rows?[indx]["subtotal"].toString() ?? "",
              hasCurrency: true,
            )),
          );
        },
      ),
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
