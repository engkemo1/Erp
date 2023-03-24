import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstprojects/models/customers/create_customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../controllers/cubit/Inventory_cubit/Inventory_cubit.dart';
import '../../../../controllers/cubit/Inventory_cubit/Inventory_state.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../models/selected_bottom_sheet_model/PayType.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/storage.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_item_widget.dart';
import '../../../widgets/empty_component.dart';
import '../../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../customer_details_screen.dart';
import 'inventory_transaction_details_screen.dart';

class InventoryScreen extends StatefulWidget {
  InventoryScreen({
    required this.customerIdModel,
    required this.customer,
    required this.id,
  });

  CustomerIdModel customerIdModel;
  CreateCustomerModel customer;
  final int id;

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  double sum = 0;
  var customersController = CustomerCubit();
  List<PayType> payTypes = [];

  @override
  void initState() {
    for (var element in widget.customerIdModel.invoices!) {
      sum = sum + element.totalAfterTax!;
    }
    CustomerCubit().initialize().then((value) {
      payTypes.addAll(value.payTypes!);
    });
    super.initState();
  }

  String _getTitle() {
    return widget.id == 1
        ? 'sales invoices'.tr
        : widget.id == 2
            ? 'Purchase order'.tr
            : 'Sales returns'.tr;
  }

  String _getSubtitle() {
    return widget.id == 1
        ? 'A list of sales invoices for the customer'.tr
        : widget.id == 2
            ? 'Request to purchase products and send them to the administration for follow-up'
                .tr
            : 'Invoice details'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RoundedAppBar(
          onTap: () {
            Get.to(CustomerDetailsScreen(
              customer: widget.customer,
            ));
          },
          icon: const Icon(Icons.description),
          title: _getTitle(),
          subtitle: _getSubtitle(),
        ),
        body: WillPopScope(
            onWillPop: () async {
              Get.to(CustomerDetailsScreen(
                customer: widget.customer,
              ));

              return false;
            },
            child: BlocProvider(
                create: (context) => InventoryCubit()
                  ..getInventory(
                      widget.id, widget.customerIdModel.id!.toString()),
                child: BlocConsumer<InventoryCubit, InventoryMainState>(
                    listener: (BuildContext context, state) {},
                    builder: (BuildContext context, state) {
                      var data = InventoryCubit.get(context);
                      if (state is GetInventorySuccessState) {
                        sum = 0;
                        for (var element in data.invoicesModeList) {
                          sum = sum + element.totalAfterTax!;
                        }
                      }

                      return state is GetInventoryLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SafeArea(
                              child: data.invoicesModeList.isEmpty
                                  ? Column(
                                      children: [
                                        Expanded(
                                            child: EmptyComponent(
                                          iconName: 'error'.tr,
                                          text:
                                              'There are no receipt voucher movements'
                                                  .tr,
                                        )),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? DARK_GREY3
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          25.r))),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 10.h),
                                          alignment: Alignment.center,
                                          child: CustomButton(
                                            onTap: () {
                                              onTapAdd();
                                            },
                                            text: 'addition'.tr,
                                            width: MediaQuery.of(context)
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            //mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Get.isDarkMode
                                                        ? DARK_GREY3
                                                        : Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 18.h,
                                                      horizontal: 5.w),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: data
                                                        .invoicesModeList
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Column(
                                                        children: [
                                                          InkWell(
                                                            child:
                                                                DefaultItemWidget(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                              icon: const Icon(
                                                                  Icons
                                                                      .receipt_long_outlined,
                                                                  color: Constants
                                                                      .primaryColor),
                                                              title: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        widget.id ==
                                                                                1
                                                                            ? 'Sales bill'.tr
                                                                            : widget.id == 2
                                                                                ? 'Purchase order'.tr
                                                                                : 'Sales returns'.tr,
                                                                        style:
                                                                            TextStyle(
                                                                          color: !Get.isDarkMode
                                                                              ? Colors.blue.shade900
                                                                              : Colors.grey,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '#${data.invoicesModeList[index].transactionNo}',
                                                                        style:
                                                                            TextStyle(
                                                                          color: !Get.isDarkMode
                                                                              ? Colors.blue.shade900
                                                                              : Colors.grey,
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                                                        Icons
                                                                            .date_range,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            14,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        formatDate(DateTime.parse(data
                                                                            .invoicesModeList[index]
                                                                            .transactionDate!)),
                                                                        style:
                                                                            TextStyle(
                                                                          color: !Get.isDarkMode
                                                                              ? Colors.blue.shade800
                                                                              : Colors.grey,
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              tail: Text(
                                                                data
                                                                    .invoicesModeList[
                                                                        index]
                                                                    .totalAfterTax!
                                                                    .toStringAsFixed(
                                                                        3),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .blue[
                                                                      600],
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              InventoryCubit()
                                                                  .getInventoryById(
                                                                      data
                                                                          .invoicesModeList[
                                                                              index]
                                                                          .uuid,
                                                                      widget.id)
                                                                  .then(
                                                                      (value) {
                                                                Get.to(
                                                                    InventoryTransactionDetailsScreen(
                                                                  payTypes:
                                                                      payTypes,
                                                                  customerIdModel:
                                                                      widget
                                                                          .customerIdModel,
                                                                  id: widget.id,
                                                                  invoiceId: data
                                                                      .invoicesModeList[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  customer: widget
                                                                      .customer,
                                                                  invoicesModel:
                                                                      value,
                                                                ));
                                                              });
                                                            },
                                                          ),
                                                          const Divider(
                                                            thickness: 0.4,
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Get.isDarkMode
                                                        ? DARK_GREY3
                                                        : Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Column(
                                                  children: [
                                                    DefaultItemWidget(
                                                      title: Text(
                                                        'Total'.tr,
                                                        style: TextStyle(
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Constants
                                                                  .textColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      tail: Text(
                                                        '${double.parse(sum.toStringAsFixed(3)).toStringAsFixed(3) ?? 0}',
                                                        style: TextStyle(
                                                          color: Get.isDarkMode
                                                              ? Colors.blueGrey
                                                              : Constants
                                                                  .primaryColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
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
                                              color: Get.isDarkMode
                                                  ? DARK_GREY3
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          25.r))),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 10.h),
                                          alignment: Alignment.center,
                                          child: CustomButton(
                                            color: getUser()!
                                                        .welcomeUserPermissions![
                                                    "sales_invoices.print"]!
                                                ? null
                                                : Colors.grey,
                                            onTap: () {
                                              onTapAdd();
                                            },
                                            text: 'addition'.tr,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                        )
                                      ],
                                    ),
                            );
                    }))));
  }

  onTapAdd() async {
    if (GetStorage().read("accountNo") == widget.customerIdModel.id) {
      getUser()!.welcomeUserPermissions!["journal_receivable.create"]!
          ? Get.to(() => InventoryTransactionDetailsScreen(
                id: widget.id,
                customerIdModel: widget.customerIdModel,
                customer: widget.customer,
                payTypes: payTypes,
              ))
          : null;
    } else if (GetStorage().read("isVisit") == false ||
        GetStorage().read("isVisit") == null) {
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
