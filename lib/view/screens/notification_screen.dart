import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:firstprojects/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

const externalUserId = 'demo@accountly.me';

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  AuthCubit authController = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
          centerTitle: true,
          elevation: 1,
          title: Text(
            'Notifications'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : Constants.textColor2,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),
            ...List.generate(
                4,
                (index) => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Notification title xx',
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Constants.textColor2,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'Lorem Ipsum is simply dummy',
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Constants.textColor3,
                            fontSize: 14.sp,
                          ),
                        ),
                        leading: Container(
                            height: 55.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Constants.primaryColor.withOpacity(0.1)),
                            child: const Center(
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Constants.primaryColor,
                                size: 35,
                              ),
                            )),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Constants.textColor3,
                          ),
                        ),
                      ),
                    ))
          ]),
        )));
  }
}
// You will supply the external user id to the OneSignal SDK

// Setting External User Id with Callback Available in SDK Version 3.9.3+

