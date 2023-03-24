import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../default_item_widget.dart';

class BarClientWidget extends StatelessWidget {
  final String accountName;
  final String accountNo;
  final String total;
  final Widget widget;
  const BarClientWidget(
      {Key? key,
      required this.accountName,
      required this.accountNo,
      required this.widget,
      required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            DefaultItemWidget(
              width: 50.w,
              height: 50.h,
              icon: SvgPicture.asset('assets/images/clients.svg'),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    accountName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color:
                          Get.isDarkMode ? Colors.white : Constants.textColor3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    accountNo,
                    style: TextStyle(
                      color:
                          Get.isDarkMode ? Colors.grey : Constants.textColor3,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              thickness: 0.4,
            ),
            widget,
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.insert_drive_file_outlined),
                  Text(
                    'Total'.tr,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Constants.textColor3,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              trailing: Text(
                total,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Constants.primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
