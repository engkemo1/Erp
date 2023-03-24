import 'package:firstprojects/view/screens/app_screens/reports_screen/widgets/reports_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../bottom_navigation_screen.dart';
import '../../../widgets/app_bar_widget/custom_app_bar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode ? DARK_GREY2 : null,
        appBar: CustomAppBar(
          title: 'Reports'.tr,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.offAll(BottomNavigationScreen(
              index: 0,
            ));
            return false;
          },
          child: const ReportsBody(),
        ));
  }
}
