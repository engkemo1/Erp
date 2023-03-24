import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final Function()? onTap;
  final EdgeInsetsGeometry ?padding;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  const CustomButton(
      {Key? key,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.color,
      this.textColor,
      this.borderColor,
      this.borderRadius,
      this.textStyle, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor:Constants.primaryColor ,
      onTap: onTap,
      child: Container(
        height: height??55.h,
        width: width??250.w,
        decoration: BoxDecoration(
          color: color ?? Constants.primaryColor,
          border: Border.all(color: borderColor??Colors.transparent),

          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        padding:padding,
        child: Center(
          child: Text(
            text ?? '',
            style: textStyle ??
                TextStyle(
                  fontSize: 18.sp,
        color:textColor?? Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'IBM Plex Sans Arabic',
                ),
          ),
        ),
      ),
    );
  }
}
