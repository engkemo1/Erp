import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/storage.dart';
import '../../explore_clients_screen.dart';
import '../../notification_screen.dart';
import '../../offers/offer_screen/offer_screen.dart';
import '../../prepare_orders/prepare_orders_screen.dart';
import '../../tours_screen.dart';
import 'widgets/category_item_widget.dart';
import 'widgets/items_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final String date2 = DateFormat('yyyy-MM-dd').format(DateTime.now());

  AuthCubit authController = AuthCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return await AwesomeDialog(
          dialogBackgroundColor: Get.isDarkMode ? DARK_GREY : Colors.white,
          context: context,
          padding: const EdgeInsets.all(20),
          btnCancel: Row(
            children: [
              InkWell(
                onTap: () {
                  exit(0);
                },
                child: Text(
                  'YES'.tr,
                  style: const TextStyle(
                      color: Colors.greenAccent, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'NO'.tr,
                  style: const TextStyle(
                      color: Colors.greenAccent, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Wallet ERP',
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white70 : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Are you sure you want to close App'.tr,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white70 : Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          dialogType: DialogType.NO_HEADER,
          animType: AnimType.BOTTOMSLIDE,
        ).show();
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: Get.isDarkMode
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [DARK_GREY, DARK_GREY2])
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                        Constants.textColor2,
                        Color.fromARGB(255, 248, 248, 248)
                      ])),
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            InkWell(
              child: Container(
                height: Get.height * 0.5,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Get.isDarkMode
                        ? [DARK_GREY2, DARK_GREY]
                        : [
                            const Color.fromARGB(255, 25, 120, 197),
                            Constants.textColor2
                          ],
                  ),
                ),
              ),
            ),
            Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    top: 34.h, left: 10, right: 10, bottom: 0.h),
                // margin: EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getUser()!
                              .userCompanies!
                              .first
                              .company!
                              .companyName
                              .toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.notifications_none,
                                  color: Get.isDarkMode
                                      ? Colors.grey[500]
                                      : LIGHT_GREY1,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Get.to(const NotificationScreen());
                                },
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    buildMainItems(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 15.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                    color: Get.isDarkMode
                        ? DARK_GREY3
                        : const Color.fromARGB(255, 248, 248, 248),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Daily transaction'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Constants.textColor2),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Constants.textColor2
                                    : Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(date2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor2)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildBarSelecteable(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: ItemsWidget(
                          name: 'Hasan#12',
                          date: '14-9-2022',
                          image: 'assets/images/reports.svg',
                          cost: '21.00',
                          isDarkMode: Get.isDarkMode,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ])
          ],
        ),
      ),
    ));
  }

  Container buildMainItems() {
    return Container(
      padding: const EdgeInsets.only(top: 1, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CategoryItemWidget(
              onTap: () {
                Get.to(const OffersScreen());
              },
              height: 65.h,
              width: 65.w,
              title: 'Offers'.tr,
              icon: SvgPicture.asset('assets/images/offer.svg'),
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              height: 65.h,
              width: 65.w,
              onTap: () {
                Get.to(const ExploreClientsScreen());
              },
              title: 'Discover customers'.tr,
              icon: const Icon(
                Icons.location_history,
                color: Constants.primaryColor,
                size: 36,
              ),
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              height: 65.h,
              width: 65.w,
              onTap: () {
                Get.to(const ToursScreen());
              },
              title: 'Tours'.tr,
              icon: SvgPicture.asset('assets/images/location.svg'),
            ),
          ),
          Expanded(
            child: CategoryItemWidget(
              onTap: () {
                Get.to(const PrepareOrdersScreen());
              },
              height: 65.h,
              width: 65.w,
              title: 'Prepare the orders'.tr,
              icon: SvgPicture.asset(
                'assets/images/mdpi.svg',
                color: Constants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildBarSelecteable() {
    return Container(
      color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildDetails(
            () {
              if (selectedCategory == 2) return;
              setState(() {
                selectedCategory = 2;
              });
            },
            selectedCategory == 2,
            'returns'.tr,
            Colors.red,
            'assets/images/expenses-mdpi.svg',
          ),
          buildDetails(
            () {
              if (selectedCategory == 1) return;
              setState(() {
                selectedCategory = 1;
              });
            },
            selectedCategory == 1,
            'Revenues'.tr,
            Colors.green,
            'assets/images/income-mdpi.svg',
          ),
          buildDetails(
            () {
              if (selectedCategory == 0) return;
              setState(() {
                selectedCategory = 0;
              });
            },
            selectedCategory == 0,
            'All'.tr,
            Constants.primaryColor,
            'assets/images/all.svg',
          ),
        ],
      ),
    );
  }

  InkWell buildDetails(void Function() onTap, bool isSelected, String title,
      Color color, String imagePath) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1 : 0.3,
        child: Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(imagePath),
                )),
          ],
        ),
      ),
    );
  }
}
