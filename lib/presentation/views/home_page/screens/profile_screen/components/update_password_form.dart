import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_bloc.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_event.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_state.dart';
import 'package:kapartner_app/global_bloc/blocs.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/presentation/widget/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/size_config.dart';

class UpdatePasswordForm extends StatefulWidget {
  const UpdatePasswordForm({Key? key, required this.bloc}) : super(key: key);
  final CustomerInfoBloc bloc;

  @override
  _UpdatePasswordFormState createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passIsHide = true;
  bool _confirmIsHide = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: (SizeConfig.screenHeight * .5).h,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 10.w,
            right: 10.w,
          ),
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                current is PasswordUpdating ||
                current is PasswordUpdatedSuccessfully ||
                current is PasswordUpdatingFailure,
            listener: (context, state) {
              if (state is PasswordUpdatedSuccessfully) {
                CustomDialog.success(context, message: state.message,
                    onPositiveClick: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                });
              } else if (state is PasswordUpdatingFailure) {
                CustomDialog.error(context, message: state.message);
              } else {
                CustomDialog.loading(context);
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Update Password",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.always,
                    labelText: "Password",
                    obsecureText: _passIsHide,
                    controller: _passwordController,
                    maxLines: 1,
                    suffixIcon: IconButton(
                      splashRadius: Constant.splashRadius,
                      onPressed: () {
                        setState(() {
                          _passIsHide = !_passIsHide;
                        });
                      },
                      icon: Icon(_passIsHide
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.always,
                    labelText: "Confirm Password",
                    obsecureText: _confirmIsHide,
                    controller: _confirmPasswordController,
                    maxLines: 1,
                    suffixIcon: IconButton(
                      splashRadius: Constant.splashRadius,
                      onPressed: () {
                        setState(() {
                          _confirmIsHide = !_confirmIsHide;
                        });
                      },
                      icon: Icon(_confirmIsHide
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field!';
                      } else if (value != _passwordController.text &&
                          _passwordController.text.isNotEmpty) {
                        return "Password didn't match!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (context.watch<AuthBloc>().state
                              is PasswordUpdating)
                          ? null
                          : () {
                              if (_formKey.currentState!.validate() &&
                                  _confirmPasswordController.text ==
                                      _passwordController.text) {
                                context.read<AuthBloc>().add(
                                    ChangedPassword(_passwordController.text));
                              }
                            },
                      child:
                          (context.watch<AuthBloc>().state is PasswordUpdating)
                              ? const Text("Updating...")
                              : const Text("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
