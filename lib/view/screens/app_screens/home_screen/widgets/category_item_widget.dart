import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/colors.dart';

class CategoryItemWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Widget icon;
  final double? height;
  final double? width;

  const CategoryItemWidget(
      {Key? key,
      required this.title,
      required this.icon,
      this.onTap,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            //padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Center(child: icon),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1),
          ),
        ],
      ),
    );
  }
}
