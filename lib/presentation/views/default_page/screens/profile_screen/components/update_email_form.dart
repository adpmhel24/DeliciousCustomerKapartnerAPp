import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/global_bloc/blocs.dart';
import 'package:kapartner_app/presentation/widget/custom_text_field.dart';

import '../../../../../utils/size_config.dart';

class UpdateEmailForm extends StatefulWidget {
  const UpdateEmailForm({Key? key, required this.bloc, this.contactNumber})
      : super(key: key);
  final String? contactNumber;
  final CustomerInfoBloc bloc;

  @override
  _UpdateEmailFormState createState() => _UpdateEmailFormState();
}

class _UpdateEmailFormState extends State<UpdateEmailForm> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void initState() {
    _controller.text = widget.contactNumber ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: (SizeConfig.screenHeight * .4).h,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update Email Address",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  autovalidateMode: AutovalidateMode.always,
                  labelText: "Email Address",
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required field!';
                    } else if (!emailValid.hasMatch(value)) {
                      return 'Invalid Email Address';
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.bloc.add(EmailAddressUpdated(_controller.text));
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
