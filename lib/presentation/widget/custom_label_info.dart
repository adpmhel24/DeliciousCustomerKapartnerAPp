import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelInfo extends StatelessWidget {
  const LabelInfo({
    Key? key,
    required this.label,
    this.child,
    this.labelStyle,
  }) : super(key: key);

  final String label;
  final TextStyle? labelStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? TextStyle(fontSize: 11.sp),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: const Color(0xFFeeeee4),
          ),
          child: child,
        )
      ],
    );
  }
}
