import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'custom_button.dart';

class BottomNavigationWidget extends StatefulWidget {
  final void Function() onTapAdd;
  final void Function() onTap;
  final Color? color;

  const BottomNavigationWidget(
      {Key? key, required this.onTapAdd, required this.onTap, this.color})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: widget.onTapAdd,
                child: Container(
                    width: 53.w,
                    height: 53.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 2,
                          color: Constants.primaryColor,
                        )),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: Constants.primaryColor,
                      ),
                    )),
              ),
              SizedBox(
                width: 15.h,
              ),
              Expanded(
                child: CustomButton(
                  color: widget.color ?? null,
                  onTap: widget.onTap,
                  text: 'Confirmation'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
