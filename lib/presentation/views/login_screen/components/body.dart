import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import '../bloc/bloc.dart';
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
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150.h),
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
              // SizedBox(height: 5.h),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text('Forgot Password'),
              // ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: (context
                          .watch<LoginFormBloc>()
                          .state
                          .status
                          .isValidated)
                      ? () {
                          context.read<LoginFormBloc>().add(LoginSubmitted());
                        }
                      : null,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 18.h),
              // Wrap(
              //   crossAxisAlignment: WrapCrossAlignment.center,
              //   children: [
              //     const Text("Does not have an account? "),
              //     TextButton(
              //       onPressed: () {
              //         AutoRouter.of(context)
              //             .push(const RegistrationScreenRoute());
              //       },
              //       child: const Text(
              //         'Sign In',
              //         style: TextStyle(fontStyle: FontStyle.italic),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
