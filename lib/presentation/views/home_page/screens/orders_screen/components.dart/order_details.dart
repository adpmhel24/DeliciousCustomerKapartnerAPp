import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kapartner_app/data/models/models.dart';
import 'package:kapartner_app/presentation/utils/currency_formater.dart';

import '../../../../../widget/constant.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final OrderItemModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order No ${order.id}",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                ),
                Text(
                  order.orderStatus == 0 && order.docstatus != 'N'
                      ? "Pending"
                      : order.orderStatus == 1 && order.docstatus != 'N'
                          ? "To Deliver"
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
            SizedBox(
              height: 10.h,
            ),
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
            SizedBox(
              height: 10.h,
            ),
            ColumnLabelInfo(
              label: "Ship to",
              child: Text(
                order.address ?? "",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              color: Constant.dividerColor,
              thickness: 1,
            ),
            itemDetails(),
            const Divider(
              color: Constant.dividerColor,
              thickness: 1,
            ),
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
          ],
        ),
      ),
    );
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
                      order.rows?[indx]["discprcnt"].toString() ?? "",
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
