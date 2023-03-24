import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../utils/colors.dart';

class SelectThemes extends StatefulWidget {
  SelectThemes({Key? key}) : super(key: key);

  @override
  State<SelectThemes> createState() => _SelectThemesState();
}

class _SelectThemesState extends State<SelectThemes> {
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (SettingController controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildIconWidget(),
              Switch(
                // activeTrackColor: Get.isDarkMode ? Colors.blue : Colors.blue,
                // activeColor: Get.isDarkMode ? Colors.blue : Colors.blue,
                value: controller.swithchValue.value,
                onChanged: (value) {
                  ThemeController().changesTheme();
                  controller.swithchValue.value = value;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildIconWidget() {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(
            Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Get.isDarkMode ? Colors.grey[600] : GREY,
            size: 28,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            Get.isDarkMode ? 'Dark Mode'.tr : 'Light Mode'.tr,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.grey : Colors.blue[900],
            ),
          ),
        ],
      ),
    );
  }
}
