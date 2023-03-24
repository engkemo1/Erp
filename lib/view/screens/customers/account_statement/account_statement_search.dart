import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../models/bonds_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/default_item_widget.dart';

class AccountStatementResultSearch extends StatefulWidget {
  final Bonds bonds;

  const AccountStatementResultSearch({
    Key? key,
    required this.bonds,
  }) : super(key: key);

  @override
  State<AccountStatementResultSearch> createState() =>
      _AccountStatementResultSearchState();
}

class _AccountStatementResultSearchState
    extends State<AccountStatementResultSearch> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: 'statement of account'.tr,
              ),
              Tab(text: 'Checks'.tr),
            ],
          ),
          title: Text(
            'Account statement'.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Constants.textColor2),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.local_printshop_outlined,
                  color: Constants.textColor2,
                ))
          ],
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_outlined)),
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Container(
              // padding: EdgeInsets.symmetric(vertical:10.h,horizontal: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
              child: widget.bonds.cheques != 0
                  ? TabBarView(controller: _tabController, children: <Widget>[
                      buildAccount(widget.bonds),
                      buildCheques(widget.bonds)
                    ])
                  : Center(
                      child: Text('No data'.tr),
                    ),
            ),
          ),
        )));
  }

  buildCheques(Bonds data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                children: List.generate(
                  data.cheques!.length,
                  (index) {
                    return Column(children: [
                      DefaultItemWidget(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(10.r),
                        icon: SvgPicture.asset(
                          'assets/images/report.svg',
                          color: Constants.primaryColor,
                          height: 30,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    '${data.cheques![index].bankName} ${data.cheques![index].chequeNo}#'
                                        .tr,
                                    style: TextStyle(
                                      color: !Get.isDarkMode
                                          ? Colors.blue.shade900
                                          : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  data.cheques![index].chequeDate.toString(),
                                  style: TextStyle(
                                    color: !Get.isDarkMode
                                        ? Colors.blue.shade800
                                        : Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        tail: Text(
                          data.cheques![index].chequeAmount!.toStringAsFixed(3),
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Divider(
                      //   color: Colors.grey[200],
                      // )
                    ]);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff113d6b),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'number of checks'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        data.cheques!.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total Checks'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        data.chequeAmount!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  buildAccount(Bonds data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          child: Column(
        children: [
          ...List.generate(
            data.cheques!.length,
            (index) => DefaultItemWidget.smallIcon(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10.r),
              icon: SvgPicture.asset(
                'assets/images/report.svg',
                color: Constants.primaryColor,
                height: 30,
              ),
              title: SizedBox(
                height: 45.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'receipt voucher number'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Get.isDarkMode
                                  ? Colors.white70
                                  : Constants.primaryColor),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          data.cheques![index].chequeNo.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Colors.white70
                                : Constants.primaryColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Icon(
                            // size: 20.r,
                            Icons.calendar_month_outlined,
                            color: Get.isDarkMode
                                ? Colors.grey
                                : Constants.textColor3,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            data.cheques![index].chequeDate.toString(),
                            style: TextStyle(
                              fontSize: 11,
                              color: Get.isDarkMode
                                  ? Colors.grey
                                  : Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              tail: Text(
                '${data.chequeAmount}',
                style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xff113d6b),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Creditor'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      data.chequeAmount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Debtor'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      data.count.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${data.finalBalance.toString()} د',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
