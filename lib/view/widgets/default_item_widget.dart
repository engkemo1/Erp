import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultItemWidget extends StatelessWidget {
  final Widget? icon;
  final Widget title;
  final Widget? tail;
  final Function()? onTap;
  final EdgeInsets? iconPadding;
  final double? height;
  final double? width;

  final EdgeInsets? padding;
  const DefaultItemWidget({
    Key? key,
    this.onTap,
    this.icon,
    required this.title,
    this.tail,
    this.iconPadding,
    this.padding,
    this.height,
    this.width,
  }) : super(key: key);

  const DefaultItemWidget.smallIcon({
    Key? key,
    this.onTap,
    this.icon,
    required this.title,
    this.tail,
    this.iconPadding,
    this.padding,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Container(
                height: height ?? null,
                width: width ?? null,
                decoration: BoxDecoration(
                    color: const Color(0xff0c60cb).withOpacity(0.10000000149011612),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: icon,
                ),
              ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: title,
            ),
            if (tail != null)
              const SizedBox(
                width: 10,
              ),
            if (tail != null) tail!
          ],
        ),
      ),
    );
  }
}
