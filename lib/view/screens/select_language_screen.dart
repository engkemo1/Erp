import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../widgets/custom_radio_button.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'Choose your preferred language'.tr,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Constants.textColor2),
        ),
        Text(
          'The language of the application depends on your choice.'.tr,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? Colors.white
                  : Constants.primaryColor.withOpacity(0.5)),
        ),
        SizedBox(
          height: 20.h,
        ),
        ...List.generate(
          Constants.locales.length,
          (index) => InkWell(
            onTap: () {
              if (Get.locale?.languageCode ==
                  Constants.locales[index].local.languageCode) {
                return;
              }
              Get.updateLocale(Constants.locales[index].local);
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                    title: Text(
                      Constants.locales[index].name,
                    ),
                    leading: Container(
                      height: 55.h,
                      width: 55.w,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Constants.locales[index].name == 'English'
                              ? const Color(0xffFFEDF4)
                              : const Color(0xffE7F4F0),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Image.asset(Constants.locales[index].image),
                      ),
                    ),
                    trailing: CustomRadioButton(
                      color: Get.isDarkMode
                          ? Colors.blueGrey
                          : Constants.textColor2,
                      onChanged: (val) {
                        if (Get.locale?.languageCode ==
                            Constants.locales[index].local.languageCode) {
                          return;
                        }
                        Get.updateLocale(Constants.locales[index].local);
                      },
                      value: Constants.locales[index].local.languageCode ==
                          Get.locale?.languageCode,
                    ))),
          ),
        )
      ]),
    );
  }
}
