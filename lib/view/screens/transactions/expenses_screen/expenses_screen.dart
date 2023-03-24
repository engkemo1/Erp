import 'package:firstprojects/controllers/cubit/expenses_cubit/expenses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/cubit/expenses_cubit/expenses_state.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../bottom_navigation_screen.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../lost_connection_screen.dart';
import 'add_expense_screen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        icon: const Icon(Icons.account_balance_wallet_outlined),
        onTap: () {
          Get.offAll(BottomNavigationScreen(
            index: 3,
          ));
        },
        title: 'Expenses'.tr,
        subtitle: 'You can find out and add your expenses with details.'.tr,
      ),
      body: WillPopScope(
          onWillPop: () async {
            Get.offAll(BottomNavigationScreen(
              index: 3,
            ));
            return false;
          },
          child: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return connected
                  ? BlocProvider(
                      create: (context) => ExpensesCubit()..getAll(),
                      child: BlocConsumer<ExpensesCubit, ExpensesMainState>(
                          listener: (BuildContext context, state) {},
                          builder: (BuildContext context, state) {
                            var data = ExpensesCubit.get(context);
                            return state is GetExpensesLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        height: ScreenUtil().screenHeight - 160,
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? DARK_GREY3
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: ListView.separated(
                                            itemBuilder: (context, index) {
                                              var list =
                                                  data.expensesList[index];
                                              return InkWell(
                                                  onTap: () {
                                                    Get.to(AddExpenseScreen(
                                                      id: 1,
                                                      expensesModel: data
                                                          .expensesList[index],
                                                    ));
                                                  },
                                                  child: ListTile(
                                                    trailing: Text(
                                                      list.amount
                                                          .toStringAsFixed(3),
                                                      style: TextStyle(
                                                          color: Get.isDarkMode
                                                              ? Colors.blueGrey
                                                              : Constants
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    leading: Container(
                                                        height: 55.h,
                                                        width: 55.w,
                                                        decoration: BoxDecoration(
                                                            color: Constants
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(7),
                                                        child: Icon(
                                                          Icons
                                                              .account_balance_wallet_outlined,
                                                          color: Get.isDarkMode
                                                              ? Colors.blueGrey
                                                              : Constants
                                                                  .primaryColor,
                                                          size: 30,
                                                        )),
                                                    title: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: Text(
                                                        list.expensesName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: Get
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Constants
                                                                    .textColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    subtitle: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.calendar_month,
                                                          size: 15,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          list.date.toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.grey
                                                                  : Constants
                                                                      .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                                      indent: 5,
                                                      endIndent: 5,
                                                      height: 5,
                                                    ),
                                            itemCount:
                                                data.expensesList.length),
                                      )
                                    ],
                                  );
                          }))
                  : LostConnectionWidget(connected);
            },
            child: const SizedBox(),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Get.to(AddExpenseScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
