import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final void Function()? onTap;
  final bool hasDecoration;
  const RoundedAppBar({
    Key? key,
    this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.hasDecoration = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.only(right: 9.h),
      decoration: const BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: Row(
        children: [
          if (icon != null)
            Container(
                decoration: !hasDecoration
                    ? null
                    : BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(12),
                child: icon),
          if (icon != null)
            const SizedBox(
              width: 12,
            ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                subtitle ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    height: 1),
              ),
            ],
          )),
          IconButton(
              onPressed: onTap ??
                  () {
                    Navigator.pop(context);
                  },
              icon: const Icon(
                Icons.close_outlined,
                color: Colors.white,
                size: 30,
              )),
        ],
      ),
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(90.h);
}
