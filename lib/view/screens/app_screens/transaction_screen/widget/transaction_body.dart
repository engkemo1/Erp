import 'package:firstprojects/view/screens/customers/visit_screen/visit_details_screen.dart';
import 'package:firstprojects/view/screens/transactions/salesman_screen/salesman_screen.dart';
import 'package:firstprojects/view/widgets/customers/account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../utils/constants.dart';
import '../../../../widgets/default_item_widget.dart';
import '../../../transactions/expenses_screen/expenses_screen.dart';
import '../../../transactions/transfer_screen/transfer_screen.dart';

class TransactionsBody extends StatelessWidget {
  const TransactionsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1, bottom: 8),
      child: ListView(
        children: [
          GetStorage().read('accountNo') != null
              ? InkWell(
                  onTap: () {
                    Get.to(() => VisitDetailsScreen());
                  },
                  child: AccountWidget(),
                )
              : const SizedBox(),
          const SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  onTap: () {
                    Get.to(const ExpensesScreen());
                  },
                  icon: SvgPicture.asset(
                    'assets/images/reports.svg',
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expenses'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white
                              : Constants.textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'You can find out and add your expenses with details'
                            .tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey
                              : Constants.textColor3,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 8,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TransferScreen()));
                  },
                  height: 60.h,
                  width: 60.w,
                  icon: SvgPicture.asset(
                    'assets/images/reports.svg',
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer between warehouses'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white
                              : Constants.textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'The information'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey
                              : Constants.textColor3,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 8,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  onTap: () {
                    Get.to(() => const SalesmanScreen(
                          isScreen: true,
                        ));
                  },
                  icon: SvgPicture.asset(
                    'assets/images/reports.svg',
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Salesman'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white
                              : Constants.textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Choose the delegate'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey
                              : Constants.textColor3,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
