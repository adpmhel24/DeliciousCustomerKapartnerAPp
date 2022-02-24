import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../router/router.gr.dart';
import 'form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            right: 24.h,
            bottom: MediaQuery.of(context).viewPadding.bottom.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              AspectRatio(
                aspectRatio: 4 / 2,
                child: SizedBox(
                  height: 200.h,
                  width: 300.w,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              const LoginForm(),
              SizedBox(height: 5.h),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password'),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: const ElevatedButton(
                  onPressed:
                      // (context
                      //         .watch<LoginBloc>()
                      //         .state
                      //         .status
                      //         .isValidated)
                      //     ? () {
                      //         context
                      //             .read<LoginBloc>()
                      //             .add(const LoginSubmitted());
                      //       }
                      //     :
                      null,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("Does not have an account? "),
                  TextButton(
                    onPressed: () {
                      AutoRouter.of(context)
                          .push(const RegistrationTypeScreenRoute());
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
