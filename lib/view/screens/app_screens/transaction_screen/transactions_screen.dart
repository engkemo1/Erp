import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../bottom_navigation_screen.dart';
import '../../../widgets/app_bar_widget/custom_app_bar.dart';
import 'widget/transaction_body.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode ? DARK_GREY2 : null,
        appBar: CustomAppBar(
          title: 'Transactions'.tr,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.offAll(BottomNavigationScreen(
              index: 0,
            ));
            return false;
          },
          child: const TransactionsBody(),
        ));
  }
}
