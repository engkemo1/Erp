import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';
import 'screens/app_screens/customers_screens/customers_screen.dart';
import 'screens/app_screens/home_screen/home_screen.dart';
import 'screens/app_screens/more_screen/more_screen.dart';
import 'screens/app_screens/reports_screen/reports_screen.dart';
import 'screens/app_screens/transaction_screen/transactions_screen.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({
    Key? key,
    this.index,
  }) : super(key: key);
  int? index;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.index ?? 0);
    selectedPage = widget.index ?? 0;
  }

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? selectedPage == 4
              ? DARK_GREY2
              : DARK_GREY2
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            )),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  pageController.jumpToPage(0);
                  setState(() {
                    selectedPage = 0;
                  });
                },
                child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: selectedPage == 0
                              ? Constants.primaryColor
                              : Colors.grey,
                        ),
                        FittedBox(
                          child: Text(
                            'Main'.tr,
                            style: TextStyle(
                              color: selectedPage == 0
                                  ? Constants.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  pageController.jumpToPage(1);
                  setState(() {
                    selectedPage = 1;
                  });
                },
                child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/clients.svg',
                            color: selectedPage == 1
                                ? Constants.primaryColor
                                : Colors.grey),
                        FittedBox(
                          child: Text(
                            'Customers'.tr,
                            style: TextStyle(
                              color: selectedPage == 1
                                  ? Constants.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  pageController.jumpToPage(2);
                  setState(() {
                    selectedPage = 2;
                  });
                },
                child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long,
                            color: selectedPage == 2
                                ? Constants.primaryColor
                                : Colors.grey),
                        FittedBox(
                          child: Text(
                            'Reports'.tr,
                            style: TextStyle(
                              color: selectedPage == 2
                                  ? Constants.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  pageController.jumpToPage(3);
                  setState(() {
                    selectedPage = 3;
                  });
                },
                child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_circle_up,
                            color: selectedPage == 3
                                ? Constants.primaryColor
                                : Colors.grey),
                        FittedBox(
                          child: Text(
                            'Transactions'.tr,
                            style: TextStyle(
                              color: selectedPage == 3
                                  ? Constants.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  pageController.jumpToPage(4);
                  setState(() {
                    selectedPage = 4;
                  });
                },
                child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      children: [
                        Icon(Icons.more_horiz,
                            color: selectedPage == 4
                                ? COLOR_PRIMARY2
                                : Colors.grey),
                        FittedBox(
                          child: Text(
                            'More'.tr,
                            style: TextStyle(
                              color: selectedPage == 4
                                  ? COLOR_PRIMARY2
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomeScreen(),
          CustomersScreen(),
          ReportsScreen(),
          TransactionsScreen(),
          MenuScreen(),
        ],
      ),
    );
  }
}
