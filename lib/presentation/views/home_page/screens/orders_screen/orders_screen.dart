import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'delivered_orders/delivered_orders_screen.dart';
import 'pending_orders/pending_orders_screen.dart';
import 'to_deliver_orders/to_deliver_orders_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Orders"),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
              padding: EdgeInsets.only(bottom: 5.h),
              unselectedLabelColor: Colors.redAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.redAccent,
              ),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Pending"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.redAccent, width: 1),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("To Deliver"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Delivered"),
                    ),
                  ),
                ),
              ]),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PendingOrdersScreen(),
            ToDeliverOrdersScreen(),
            DeliveredOrdersScreen(),
          ],
        ),
      ),
    );
  }
}
