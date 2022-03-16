import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomDialog {
  //  Loading
  static loading(context) {
    return showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 100.h,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }

  static warning(
    context, {
    required String message,
    void Function()? onPositiveClick,
    void Function()? onNegativeClick,
  }) {
    return showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.warning),
          ),
          content: Text(message),
          actions: [
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red[300]),
              ),
              onPressed: (onNegativeClick == null)
                  ? Navigator.of(context).pop
                  : onNegativeClick,
              child: const Text('Cancel'),
            ),
            TextButton(onPressed: onPositiveClick, child: const Text('Okay')),
          ],
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }

  // Error Dialog Modal
  static error(BuildContext context,
      {required String message,
      void Function()? onPositiveClick,
      bool? barrierDismissible}) {
    // Navigator.of(context).pop();
    context.loaderOverlay.hide();
    return showAnimatedDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ClassicGeneralDialogWidget(
            titleText: 'Error!',
            contentText: message,
            positiveText: 'Okay',
            onPositiveClick: onPositiveClick ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }

  // Success Dialog Modal
  static success(
    BuildContext context, {
    required String message,
    void Function()? onPositiveClick,
  }) {
    context.loaderOverlay.hide();
    return showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Success!',
          contentText: message,
          positiveText: 'Okay',
          onPositiveClick: onPositiveClick,
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }
}
