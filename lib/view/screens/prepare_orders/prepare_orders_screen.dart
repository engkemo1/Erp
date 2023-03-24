import 'package:firstprojects/view/screens/prepare_orders/prepare_orders_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/cubit/prepare_goods_cubit/prepare_goods_cubit.dart';
import '../../../controllers/cubit/prepare_goods_cubit/prepare_goods_state.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../bottom_navigation_screen.dart';
import '../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../lost_connection_screen.dart';

class PrepareOrdersScreen extends StatefulWidget {
  const PrepareOrdersScreen({Key? key}) : super(key: key);

  @override
  _PrepareOrdersScreenState createState() => _PrepareOrdersScreenState();
}

class _PrepareOrdersScreenState extends State<PrepareOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        icon: const Icon(Icons.receipt_long_outlined),
        onTap: () {
          Get.offAll(BottomNavigationScreen(
            index: 0,
          ));
        },
        title: 'Prepare orders'.tr,
        subtitle:
            'You can request items and products from the administration before the start of the working day.'
                .tr,
      ),
      body: WillPopScope(
          onWillPop: () async {
            Get.offAll(BottomNavigationScreen(
              index: 0,
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
                      create: (context) =>
                          PrepareGoodsCubit()..getPrepareGoods(),
                      child:
                          BlocConsumer<PrepareGoodsCubit,
                                  PrepareGoodsMainState>(
                              listener: (BuildContext context, state) {},
                              builder: (BuildContext context, state) {
                                var data = PrepareGoodsCubit.get(context);

                                return state is GetPrepareGoodsLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : SafeArea(
                                        child: ListView(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            children: List.generate(
                                                data.listPrepareGoodModel
                                                    .length,
                                                (index) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            left: 10,
                                                            right: 10),
                                                    padding: EdgeInsets.only(
                                                        left: 10.w,
                                                        bottom: 10.h,
                                                        top: 10.h),
                                                    decoration: BoxDecoration(
                                                        color: Get.isDarkMode
                                                            ? DARK_GREY3
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: InkWell(
                                                      onTap: () {
                                                        PrepareGoodsCubit()
                                                            .getPrepareGoodsById(data
                                                                .listPrepareGoodModel[
                                                                    index]
                                                                .uuid
                                                                .toString())
                                                            .then((value) =>
                                                                Get.to(
                                                                    PrepareOrdersDetailsScreen(
                                                                  prepareGoodModel:
                                                                      value,
                                                                )));
                                                      },
                                                      child: ListTile(
                                                          leading: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black12,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Icon(
                                                              Icons.receipt,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors
                                                                      .blueGrey
                                                                  : Constants
                                                                      .primaryColor,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          title: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Text(
                                                              data
                                                                      .listPrepareGoodModel[
                                                                          index]
                                                                      .salesmen!
                                                                      .name ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.sp,
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Constants
                                                                          .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          subtitle: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .calendar_month,
                                                                      size: 16,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            4),
                                                                    Text(
                                                                      data
                                                                          .listPrepareGoodModel[
                                                                              index]
                                                                          .transactionDate!,
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color: Get.isDarkMode
                                                                              ? Colors.blueGrey
                                                                              : Colors.grey,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'status'
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          color: Get.isDarkMode
                                                                              ? Colors.grey
                                                                              : Constants.textColor,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      data.listPrepareGoodModel[index].statusId ==
                                                                              2
                                                                          ? 'تم التأكيد'
                                                                          : 'under processing'
                                                                              .tr,
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color: data.listPrepareGoodModel[index].statusId == 2
                                                                              ? Colors.green
                                                                              : const Color(0xffEEC561),
                                                                          fontWeight: FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ])),
                                                    )))));
                              }))
                  : LostConnectionWidget(connected);
            },
            child: const SizedBox(),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Get.to(PrepareOrdersDetailsScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
