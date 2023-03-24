import 'package:firstprojects/controllers/cubit/material_cubit/material_cubit.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../models/items_model/material_customer_report.dart';
import '../../../utils/constants.dart';
import '../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/date_entry_field.dart';

class ArticleReport extends StatefulWidget {
  ArticleReport({Key? key, required this.itemId}) : super(key: key);
  int itemId;
  @override
  State<ArticleReport> createState() => _ArticleReportState();
}

class _ArticleReportState extends State<ArticleReport> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  MaterialCustomerReportModel? materialCustomerReport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        icon: Icon(Icons.description),
        title: 'تقرير حركة مادة لعميل',
        subtitle: "عرض حركة مادة معينة لعميل او مورد",
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20.r),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DateEntryField(
                        textDirection: TextDirection.ltr,
                        hint: '2022-1-1 ',
                        label: 'من تاريخ',
                        filled: Get.isDarkMode ? true : false,
                        textEditingController: startDate,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DateEntryField(
                        textDirection: TextDirection.ltr,
                        filled: Get.isDarkMode ? true : false,
                        textEditingController: endDate,
                        label: 'الى تاريخ',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    onTap: () {
                      if (endDate.text.isEmpty || startDate.text.isEmpty) {
                        Get.snackbar("select date", "Please select Date");
                      } else {
                        MaterialCubit()
                            .getMaterialCustomerReport(
                                widget.itemId, startDate.text, endDate.text)
                            .then((value) => setState(() {
                                  materialCustomerReport = value;
                                }));
                      }
                    },
                    text: 'بحث',
                    textStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                    height: 45.h,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          // SizedBox(height: 5.h),
          materialCustomerReport != null
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                                height: 55.h,
                                width: 55.w,
                                decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? Colors.black12
                                        : Constants.textColor2.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                    'assets/images/receipt.svg')),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'فاتورة مبيعات#${materialCustomerReport!.statements![index].transactionNo}',
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white70
                                          : Colors.blue.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined,
                                        size: 16,
                                        color: Colors.blueGrey.shade300),
                                    Text(
                                      materialCustomerReport!
                                          .statements![index].transactionDate!,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.blueGrey.shade300),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.newspaper,
                                        size: 14,
                                        color: Colors.blueGrey.shade300),
                                    Text(
                                      '${materialCustomerReport!.statements![index].unitType} ${materialCustomerReport!.statements![index].unitName}',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.blueGrey.shade300),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '${materialCustomerReport!.statements![index].price}',
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                          ],
                        );
                        //   ListTile(
                        //   title: Text(
                        //     'فاتورة مبيعات#20',
                        //     style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 16.sp),
                        //   ),
                        //   trailing: Text(
                        //     '0.000',
                        //     style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 16.sp),
                        //   ),
                        //   subtitle: Column(
                        //     children: [
                        //
                        //     ],
                        //   ),
                        //
                        // );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: 10))
              : const SizedBox(),
        ],
      ),
    );
  }
}
