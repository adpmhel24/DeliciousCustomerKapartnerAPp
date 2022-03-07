import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/router/router.gr.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                "Thank you ka-Delicious! Our representative will "
                "get in touch with you shortly to confirm your order.",
                style: TextStyle(color: Color(0xFF164052)),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.home),
                SizedBox(
                  width: 10,
                ),
                Text("BACK TO HOME"),
              ],
            ),
            onPressed: () {
              AutoRouter.of(context).replace(
                const HomeScreenRoute(
                  children: [ProductsScreenRoute()],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
