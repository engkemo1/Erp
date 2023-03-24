import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leading;
  final void Function()? onTapTrailing;
  final void Function()? onTapTrailing2;
  final void Function()? onTap;

  final IconData? trailing;
  final IconData? trailing2;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
    this.trailing2,
    this.onTapTrailing,
    this.onTapTrailing2,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Text(
        title.tr,
        style: const TextStyle(
            // color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
          onPressed: onTap ??
              () {
                Get.back();
              },
          icon: Icon(
            leading,
            color: Colors.grey,
          )),
      actions: [
        IconButton(
          onPressed: onTapTrailing,
          icon: Icon(
            trailing,
            color: Colors.grey,
          ),
        ),
        trailing2 != null
            ? IconButton(
                onPressed: onTapTrailing2,
                icon: Icon(
                  trailing2,
                  color: Colors.red,
                ))
            : const SizedBox(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.h);
}
