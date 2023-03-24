import 'package:firstprojects/controllers/cubit/cash_receipt_cubit/cash_receipt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../controllers/cubit/cash_receipt_cubit/cash_receipt_cubit.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../models/customers/create_customer_model.dart';
import '../../../../models/selected_bottom_sheet_model/bank_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/storage.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_item_widget.dart';
import '../../../widgets/empty_component.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../../lost_connection_screen.dart';
import '../customer_details_screen.dart';
import 'cash_receipt_screen_details.dart';

class CashReceiptScreen extends StatefulWidget {
  CashReceiptScreen({
    required this.customerIdModel,
    this.customer,
  });

  CreateCustomerModel? customer;
  CustomerIdModel customerIdModel;

  @override
  _CashReceiptScreenState createState() => _CashReceiptScreenState();
}

class _CashReceiptScreenState extends State<CashReceiptScreen> {
  double sum = 0;
  List<BanksModel> banks = [];
  var isVisit;
  @override
  void initState() {
    CustomerCubit().getBanks().then((value) => banks.addAll(value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RoundedAppBar(
          icon: const Icon(Icons.description),
          onTap: () {
            Get.offAll(CustomerDetailsScreen(
              customer: widget.customer!,
            ));
          },
          title: 'Cash Receipt'.tr,
          subtitle: 'The clients receivable bonds appear'.tr,
        ),
        body: WillPopScope(
            onWillPop: () async {
              Get.offAll(CustomerDetailsScreen(
                customer: widget.customer!,
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
                        create: (context) => CashReceiptCubit()
                          ..getCashReceipt(
                              widget.customerIdModel.id.toString()),
                        child:
                            BlocConsumer<CashReceiptCubit,
                                    CashReceiptMainState>(
                                listener: (BuildContext context, state) {},
                                builder: (BuildContext context, state) {
                                  var data = CashReceiptCubit.get(context);
                                  if (state is GetCashReceiptSuccessState) {
                                    sum = 0;
                                    for (var element
                                        in data.cashReceiptModelList) {
                                      sum += element.cash!;
                                    }
                                  }

                                  return state is GetCashReceiptLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : SafeArea(
                                          child:
                                              data.cashReceiptModelList.isEmpty
                                                  ? Column(
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                EmptyComponent(
                                                          iconName: 'error'.tr,
                                                          text:
                                                              'There are no receipt voucher movements'
                                                                  .tr,
                                                        )),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? DARK_GREY3
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              25.r))),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.w,
                                                                  vertical:
                                                                      10.h),
                                                          alignment:
                                                              Alignment.center,
                                                          child: CustomButton(
                                                            onTap: () {
                                                              onTapAdd();
                                                            },
                                                            text: 'addition'.tr,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.7,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Expanded(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ListView(
                                                            children: [
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? DARK_GREY3
                                                                        : Colors
                                                                            .white,
                                                                    borderRadius: const BorderRadius
                                                                            .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        topRight:
                                                                            Radius.circular(20))),
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          18.h,
                                                                      horizontal:
                                                                          5.w),
                                                                  child: ListView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    itemCount: data
                                                                        .cashReceiptModelList
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Column(
                                                                        children: [
                                                                          InkWell(
                                                                            child:
                                                                                DefaultItemWidget(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                                              icon: const Icon(Icons.receipt_long_outlined, color: Constants.primaryColor),
                                                                              title: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        'Cash Receipt'.tr,
                                                                                        style: TextStyle(
                                                                                          color: !Get.isDarkMode ? Colors.blue.shade900 : Colors.grey,
                                                                                          fontSize: 16,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        '#${data.cashReceiptModelList[index].bondNo}',
                                                                                        style: TextStyle(
                                                                                          color: !Get.isDarkMode ? Colors.blue.shade900 : Colors.grey,
                                                                                          fontSize: 17,
                                                                                          fontWeight: FontWeight.bold,
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
                                                                                        formatDate(DateTime.parse(data.cashReceiptModelList[index].bondDate!)),
                                                                                        style: TextStyle(
                                                                                          color: !Get.isDarkMode ? Colors.blue.shade800 : Colors.grey,
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              tail: Text(
                                                                                data.cashReceiptModelList[index].cash!.toStringAsFixed(3),
                                                                                style: TextStyle(
                                                                                  color: Colors.blue[600],
                                                                                  fontSize: 17,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              CashReceiptCubit().getCashReceiptById(data.cashReceiptModelList[index].uuid.toString()).then((value) {
                                                                                Get.to(CashReceiptScreenDetails(
                                                                                  id: 1,
                                                                                  customerIdModel: widget.customerIdModel,
                                                                                  customer: widget.customer,
                                                                                  cashReciept: value,
                                                                                  banks: banks,
                                                                                ));
                                                                              });
                                                                            },
                                                                          ),
                                                                          const Divider(
                                                                            thickness:
                                                                                0.4,
                                                                          )
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? DARK_GREY3
                                                                        : Colors
                                                                            .white,
                                                                    borderRadius: const BorderRadius
                                                                            .only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20))),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    DefaultItemWidget(
                                                                      title:
                                                                          Text(
                                                                        'Total'
                                                                            .tr,
                                                                        style:
                                                                            TextStyle(
                                                                          color: Get.isDarkMode
                                                                              ? Colors.white
                                                                              : Constants.textColor,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      tail:
                                                                          Text(
                                                                        '${double.parse(sum.toStringAsFixed(3)).toStringAsFixed(3) ?? 0}',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Get.isDarkMode
                                                                              ? Colors.blueGrey
                                                                              : Constants.primaryColor,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? DARK_GREY3
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              25.r))),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.w,
                                                                  vertical:
                                                                      10.h),
                                                          alignment:
                                                              Alignment.center,
                                                          child: CustomButton(
                                                            color: getUser()!
                                                                        .welcomeUserPermissions![
                                                                    "journal_receivable.create"]!
                                                                ? null
                                                                : Colors.grey,
                                                            onTap: () {
                                                              onTapAdd();
                                                            },
                                                            text: 'addition'.tr,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.7,
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                }))
                    : LostConnectionWidget(connected);
              },
              child: const SizedBox(),
            )));
  }

  onTapAdd() async {
    if (GetStorage().read("accountNo") == widget.customerIdModel.id) {
      getUser()!.welcomeUserPermissions!["journal_receivable.create"]!
          ? Get.to(() => CashReceiptScreenDetails(
                customerIdModel: widget.customerIdModel,
                banks: banks,
                customer: widget.customer,
              ))
          : null;
    } else if (GetStorage().read("accountNo") == null) {
      Get.snackbar('Portfolio Financial System'.tr,
          'You cant make a visit, you have to start a new one'.tr,
          colorText: Constants.primaryColor, backgroundColor: Colors.white);
    } else if (GetStorage().read("accountNo") != widget.customerIdModel.id) {
      Get.snackbar(
          'Portfolio Financial System'.tr,
          'You have to finish the previous round to be able to start new rounds.'
              .tr,
          colorText: Constants.primaryColor,
          backgroundColor: Colors.white);
    }
  }
}
