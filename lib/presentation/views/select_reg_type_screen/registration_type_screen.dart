import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationTypeScreen extends StatefulWidget {
  const RegistrationTypeScreen({Key? key}) : super(key: key);

  @override
  _RegistrationTypeScreenState createState() => _RegistrationTypeScreenState();
}

class _RegistrationTypeScreenState extends State<RegistrationTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitWidth,
            width: 200.h,
            height: 200.h,
          ),
          Text(
            "Registered as",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 18.h,
                  color: const Color.fromARGB(255, 105, 89, 89),
                ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            width: 150.h,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Customer',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      letterSpacing: 1,
                    ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 230, 226, 15),
                    ),
                  ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Text(
                "or",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff999999),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: 150.h,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Ka-Partner',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      letterSpacing: 1,
                    ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 230, 226, 15),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
