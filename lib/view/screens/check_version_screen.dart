import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../widgets/custom_button.dart';

class CheckVScreen extends StatelessWidget {
  const CheckVScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/logo2.png'),
              ),
              const SizedBox(
                height: 40,
              ),
               Text(
                '?Update Wallet Erp'.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
               Text(

       'In-app updates is a Google Play Core libraries feature that prompts active users to update your app. The in-app updates feature is supported on ..'.tr,
                style:  const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(25.r)),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                alignment: Alignment.center,
                child: CustomButton(
                  text: 'Update',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'v1.2',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
