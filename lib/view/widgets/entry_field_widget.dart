import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class EntryField extends StatelessWidget {
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? margin;
  final Widget? tail;
  final Widget? prefix;
  final Widget? suffix;

  final FocusNode? focusNode;
  final bool? hasTitle;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final String hint;
  final void Function()? onEditingComplete;
  final double? raduis;
  final Color? color;
  final Iterable<String>? autofill;
  final String? label;
  final bool isCenter;
  final Function? onTap;

  final void Function(String)? onChanged;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool hasBorder;
  final bool filled;
  final bool enabled;
  final bool isSecure;
  final EdgeInsets? padding;
  final TextStyle? hintStyle;
  final FontWeight? labelFontWeight;

  const EntryField({
    Key? key,
    this.hasTitle = false,
    this.margin,
    this.validator,
    this.focusNode,
    this.autofill,
    this.prefix,
    this.suffix,
    this.inputType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.enabled = true,
    this.onChanged,
    this.icon,
    this.labelFontWeight,
    required this.hint,
    this.controller,
    this.hasBorder = false,
    this.filled = true,
    this.isCenter = true,
    this.isSecure = false,
    this.tail,
    this.padding,
    this.label,
    this.hintStyle,
    this.raduis,
    this.color,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label ?? '',
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? Colors.grey
                            : color ?? Constants.textColor2,
                        fontSize: 18.sp,
                        fontWeight: labelFontWeight ?? FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )
            : const SizedBox(),
        Container(
          margin: margin != null ? null : const EdgeInsets.only(right: 5, left: 5),
          decoration: BoxDecoration(
              border: !hasBorder
                  ? null
                  : Border.all(
                      color:
                          Get.isDarkMode ? Colors.blueGrey : Colors.grey[200]!),
              color: !filled
                  ? Colors.transparent
                  : Get.isDarkMode
                      ? Colors.blueGrey
                      : Colors.white,
              borderRadius: BorderRadius.circular(raduis ?? 10)),
          child: Row(
            children: [
              if (icon != null)
                SizedBox(
                  width: 4.w,
                ),
              if (icon != null) icon!,
              if (icon != null)
                SizedBox(
                  width: 4.w,
                ),
              Expanded(
                child: Center(child:TextFormField(
                  focusNode: focusNode,
                  obscureText: isSecure,
                  controller: controller ?? null,
                  enabled: enabled,
                  textInputAction: textInputAction,

                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff64819f),
                      fontFamily: 'IBM Plex Sans Arabic',),
                  validator: validator,
                  onChanged: onChanged,
                  autofillHints: autofill,
                  onFieldSubmitted: onFieldSubmitted,
                  keyboardType: inputType,
                  textAlignVertical: TextAlignVertical.top,


                  onEditingComplete: onEditingComplete,
                  textAlign: isCenter ? TextAlign.center : TextAlign.start,
                  decoration: InputDecoration(

                      border: Get.isDarkMode
                          ? OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10))
                          : InputBorder.none,
                      prefixIcon: prefixIcon ,
                      suffixIcon: suffixIcon,
                                      suffix:suffix,
                      prefix:prefix ,

                      focusedBorder: Get.isDarkMode
                          ? OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10))
                          : InputBorder.none,
                      hintText: hint,
                      hintStyle: hintStyle ??
                          TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                      suffixIconConstraints: const BoxConstraints(maxWidth: 30),
                      fillColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                      contentPadding: padding ??
                          EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 20.h)),
                )),
              ),
              if (tail != null) tail!,
            ],
          ),
        )
      ],
    );
  }
}
