import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/cubit/transfer_cubit/transfer_cubit.dart';
import '../../../../controllers/cubit/transfer_cubit/transfer_state.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../bottom_navigation_screen.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../lost_connection_screen.dart';
import 'transfer_details_screen.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        icon: const Icon(Icons.receipt_long_outlined),
        onTap: () {
          Get.offAll(BottomNavigationScreen(
            index: 3,
          ));
        },
        title: 'Transfer between stores'.tr,
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
                      create: (context) => TransferCubit()..getTransfer(),
                      child: BlocConsumer<TransferCubit, TransferMainState>(
                          listener: (BuildContext context, state) {},
                          builder: (BuildContext context, state) {
                            var data = TransferCubit.get(context);

                            return state is GetTransferLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SafeArea(
                                    child: ListView(
                                        padding: const EdgeInsets.only(top: 10),
                                        children: List.generate(
                                          data.listTransferModel.length,
                                          (index) => Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 10, right: 10),
                                              padding: EdgeInsets.only(
                                                  left: 10.w,
                                                  bottom: 10.h,
                                                  top: 10.h),
                                              decoration: BoxDecoration(
                                                  color: Get.isDarkMode
                                                      ? DARK_GREY3
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: InkWell(
                                                onTap: () {
                                                  TransferCubit()
                                                      .getTransferId(data
                                                          .listTransferModel[
                                                              index]
                                                          .uuid
                                                          .toString())
                                                      .then((value) => Get.to(
                                                              TransferDetailsScreen(
                                                            invoicesModel:
                                                                value,
                                                          )));
                                                },
                                                child: ListTile(
                                                  leading: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Icon(
                                                      Icons.receipt,
                                                      color: Get.isDarkMode
                                                          ? Colors.blueGrey
                                                          : Constants
                                                              .primaryColor,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 2),
                                                    child: SizedBox(
                                                      width: 150,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'From'.tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
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
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                data.listTransferModel[index].fromStore ==
                                                                        null
                                                                    ? ''
                                                                    : data
                                                                            .listTransferModel[index]
                                                                            .fromStore!
                                                                            .nameAr ??
                                                                        '',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Constants
                                                                            .textColor2),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'to'.tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                data.listTransferModel[index]
                                                                            .toStore ==
                                                                        null
                                                                    ? ''
                                                                    : ' ${data.listTransferModel[index].toStore!.nameAr ?? ''}',
                                                                style: TextStyle(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Constants
                                                                            .textColor2,
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  subtitle: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_month,
                                                            size: 16.sp,
                                                            color: Colors.grey,
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(data
                                                              .listTransferModel[
                                                                  index]
                                                              .transactionDate
                                                              .toString()),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'status'.tr,
                                                            style: TextStyle(
                                                                fontSize: 13.sp,
                                                                color: Get
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .grey
                                                                    : Constants
                                                                        .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            data.listTransferModel[index]
                                                                        .statusId ==
                                                                    2
                                                                ? 'تم التأكيد'
                                                                : 'under processing'.tr,
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: data
                                                                            .listTransferModel[
                                                                                index]
                                                                            .statusId ==
                                                                        2
                                                                    ? Colors
                                                                        .green
                                                                    : const Color(
                                                                        0xffEEC561),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        )));
                          }))
                  : LostConnectionWidget(connected);
            },
            child: const SizedBox(),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Get.to(TransferDetailsScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
