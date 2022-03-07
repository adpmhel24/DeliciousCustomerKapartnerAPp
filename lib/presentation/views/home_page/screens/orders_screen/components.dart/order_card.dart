import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kapartner_app/presentation/utils/currency_formater.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';
import 'package:kapartner_app/presentation/widget/oval_button.dart';
import 'package:kapartner_app/router/router.gr.dart';

import '../../../../../../data/models/models.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderItemModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No ${order.id}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('MM/dd/yyy').format(order.transdate),
                    style: const TextStyle(
                      color: Constant.inlineLabelColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Wrap(
                children: [
                  const Text(
                    "Delivery Date:",
                    style: TextStyle(
                      color: Constant.inlineLabelColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    DateFormat('MM/dd/yyy').format(order.deliveryDate),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      const Text(
                        "Items:",
                        style: TextStyle(
                          color: Constant.inlineLabelColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        order.rows!.length.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        "Total Amount:",
                        style: TextStyle(
                          color: Constant.inlineLabelColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        formatStringToDecimal(order.doctotal.toString(),
                            hasCurrency: true),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OvalButton(
                    backgroundColor: const Color(0xFFC1A3A3),
                    onPressed: () {
                      AutoRouter.of(context).push(
                        OrderDetailsScreenRoute(order: order),
                      );
                    },
                    child: const Text("Details"),
                  ),
                  Text(
                    order.orderStatus == 0 && order.docstatus != 'N'
                        ? "Pending"
                        : order.orderStatus == 1 && order.docstatus != 'N'
                            ? "To Deliver"
                            : "Delivered",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFF76E11)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
