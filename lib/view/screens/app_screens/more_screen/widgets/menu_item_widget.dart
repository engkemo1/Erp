import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuItemWidget extends StatelessWidget {
  final Widget icon;
  final Widget? tail;
  final String title;
  final Function()? onTap;

  const MenuItemWidget({
    Key? key,
    this.tail,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
            color: Get.isDarkMode ? Colors.grey : Colors.blue[900],
            fontSize: 15.sp,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      trailing: tail,
    );
  }
}
