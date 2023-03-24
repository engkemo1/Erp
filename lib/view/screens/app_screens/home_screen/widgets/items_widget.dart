import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';

class ItemsWidget extends StatefulWidget {
  final String name;
  final String date;
  final String image;
  final String cost;
  final bool isDarkMode;

  const ItemsWidget({
    Key? key,
    required this.name,
    required this.date,
    required this.image,
    required this.cost,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

ScrollController scrollController = ScrollController();

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: CupertinoScrollbar(
        scrollbarOrientation: ScrollbarOrientation.right,
        thickness: 3.0,
        thicknessWhileDragging: 10.0,
        radius: const Radius.circular(32.0),
        controller: scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: widget.isDarkMode ? Colors.grey.shade800 : Colors.white),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        'assets/images/income-mdpi.svg',
                        color: Colors.green,
                      )),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? Colors.grey[300]
                            : Constants.textColor2,
                        fontSize: 17.sp),
                  ),
                  subtitle: Text(
                    widget.date,
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? Colors.grey[300]
                            : const Color(0xff64819f),
                        fontSize: 14.sp),
                  ),
                  trailing: Text(
                    widget.cost,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    height: 2,
                    thickness: 0.4,
                  ),
              controller: scrollController,
              itemCount: 20),
        ),
      ),
    );
  }
}
