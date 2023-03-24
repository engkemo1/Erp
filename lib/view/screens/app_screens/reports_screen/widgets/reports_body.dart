import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../utils/constants.dart';
import '../../../../widgets/customers/account_widget.dart';
import '../../../../widgets/default_item_widget.dart';
import '../../../customers/visit_screen/visit_details_screen.dart';
import '../../../reports/cash_receipt_reports_screen.dart';
import '../../../reports/inventory_reports _screen.dart';
import '../../../reports/reports_visits_salesman_screen.dart';

class ReportsBody extends StatelessWidget {
  const ReportsBody({
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
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor),
            child: Column(
              children: [
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  onTap: () {},
                  icon: SvgPicture.asset(
                    'assets/images/reports.svg',
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delegates Movement Report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Reports total delegate movements within a period'.tr,
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
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  onTap: () {
                    Get.to(const InventoryReportsScreen(
                      id: 1,
                    ));
                  },
                  height: 60.h,
                  width: 60.w,
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Invoice Report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Sales movement reports detailing cash and receivables'
                            .tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor3,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  onTap: () {
                    Get.to(const cashReceiptReportsScreen());
                  },
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receipt Report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Report cash and check receipts in a certain period of time'
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
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  onTap: () {
                    Get.to(const InventoryReportsScreen(
                      id: 3,
                    ));
                  },
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Return Report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Reports of sales returns and collection of cash and receivables'
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
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  onTap: () {
                    Get.to(const InventoryReportsScreen(
                      id: 2,
                    ));
                  },
                  height: 60.h,
                  width: 60.w,
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purchase requisition report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Detailed purchase orders reports and their number'.tr,
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
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Material Quantity Report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Dedicated report for materials inside the warehouse'
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
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  height: 60.h,
                  width: 60.w,
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items total sales report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'View all movements of total sales of items'.tr,
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
                  height: 15,
                  thickness: 0.2,
                ),
                DefaultItemWidget(
                  onTap: () {
                    Get.to(RepVisitsSalesmanScreen());
                  },
                  height: 60.h,
                  width: 60.w,
                  icon: SvgPicture.asset('assets/images/reports.svg'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Delegates visit report'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.grey.shade300
                              : Constants.textColor2,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
