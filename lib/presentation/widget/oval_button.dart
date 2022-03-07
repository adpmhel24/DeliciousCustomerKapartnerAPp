import 'package:flutter/material.dart';

class OvalButton extends StatelessWidget {
  const OvalButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? const Color(0xFFCEAB93)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: Color.fromARGB(255, 180, 154, 153),
                ),
              ),
            ),
          ),
      onPressed: onPressed,
      child: child,
    );
  }
}
