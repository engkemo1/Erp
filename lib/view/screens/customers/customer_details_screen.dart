import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstprojects/controllers/cubit/customer_cubit/customer_cubit.dart';
import 'package:firstprojects/controllers/cubit/customer_cubit/customer_state.dart';
import 'package:firstprojects/models/Customers/customer_id_model.dart';
import 'package:firstprojects/models/customers/create_customer_model.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:firstprojects/utils/storage.dart';
import 'package:firstprojects/view/bottom_navigation_screen.dart';
import 'package:firstprojects/view/screens/customers/account_statement/account_statement_screen.dart';
import 'package:firstprojects/view/widgets/custom_button.dart';
import 'package:firstprojects/view/widgets/customers/account_widget.dart';
import 'package:firstprojects/view/widgets/default_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/cubit/rep_visits_cubit/rep_visits_cubit.dart';
import '../../../models/rep_visits.dart';
import '../../../utils/colors.dart';
import 'cash_receipt/cash_receipt_screen.dart';
import 'customer_details_form.dart';
import 'info_image_screen/info_images_screen.dart';
import 'inventory_transaction/inventory_transaction.dart';
import 'visit_screen/visit_details_screen.dart';
import 'visit_screen/visits_screen.dart';

class CustomerDetailsScreen extends StatefulWidget {
  CustomerDetailsScreen({super.key, required this.customer});

  CreateCustomerModel customer;

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  var customersController = CustomerCubit();

  bool isVisit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: WillPopScope(
            onWillPop: () async {
              Get.to(BottomNavigationScreen(
                index: 1,
              ));

              return false;
            },
            child: BlocProvider(
                create: (context) =>
                    CustomerCubit()..getUserById(widget.customer.uuid),
                child: BlocConsumer<CustomerCubit, CustomerMainState>(
                    listener: (BuildContext context, state) {},
                    builder: (BuildContext context, state) {
                      var data = CustomerCubit.get(context);
                      var outputDate;
                      if (state is GetCustomerIdSuccessState) {
                        var parseDate =
                            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                .parse(data.customerIdModel.updatedAt!);
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = DateFormat('yyyy-MM-dd');
                        outputDate = outputFormat.format(inputDate);
                      }
                      return state is GetCustomerIdLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                GetStorage().read('accountNo') != null
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(() => VisitDetailsScreen(
                                                customerIdModel:
                                                    data.customerIdModel,
                                              ));
                                        },
                                        child: AccountWidget(
                                          customerIdModel: data.customerIdModel,
                                        ),
                                      )
                                    : const SizedBox(),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: ListView(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              DefaultItemWidget(
                                                height: 50,
                                                width: 50,
                                                icon: SvgPicture.asset(
                                                    'assets/images/clients.svg'),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.customerIdModel
                                                              .accountName ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Constants
                                                                .textColor3,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '${data.customerIdModel.accountNo ?? 0}',
                                                      style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.grey
                                                            : Constants
                                                                .textColor3,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                tail: getUser()!
                                                            .welcomeUserPermissions![
                                                        "additional_education.update"]!
                                                    ? CustomButton(
                                                        height: 35.h,
                                                        width: 90.w,
                                                        onTap: () {
                                                          Get.to(() =>
                                                              CustomerDetailsForm(
                                                                id: 1,
                                                                customerIdModel:
                                                                    data.customerIdModel,
                                                                customer: widget
                                                                    .customer,
                                                              ));
                                                        },
                                                        text: 'Update'.tr,
                                                        color: Get.isDarkMode
                                                            ? Colors.blueGrey
                                                            : Colors.white,
                                                        borderColor: Constants
                                                            .textColor2,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        textStyle: const TextStyle(
                                                            //    color: Colors.grey
                                                            ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const Divider(
                                                height: 2,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              DefaultItemWidget.smallIcon(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        AccountStatementScreen(
                                                          customerIdModel: data
                                                              .customerIdModel,
                                                        ));
                                                  },
                                                  height: 40,
                                                  width: 40,
                                                  icon: SvgPicture.asset(
                                                      'assets/images/report.svg',
                                                      height: 19),
                                                  title: Text(
                                                    'Balance'.tr,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Constants
                                                              .textColor3,
                                                    ),
                                                  ),
                                                  tail: Container(
                                                    margin:
                                                        const EdgeInsetsDirectional
                                                            .only(end: 10),
                                                    child: Text(
                                                      '${data.customerIdModel.balance ?? 0}',
                                                      style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.grey
                                                            : Constants
                                                                .textColor2,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  )),
                                              const Divider(
                                                height: 2,
                                                thickness: 0.2,
                                                indent: 20,
                                                endIndent: 20,
                                              ),
                                              DefaultItemWidget.smallIcon(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        AccountStatementScreen(
                                                          customerIdModel: data
                                                              .customerIdModel,
                                                        ));
                                                  },
                                                  height: 40,
                                                  width: 40,
                                                  icon: SvgPicture.asset(
                                                      'assets/images/wallet.svg'),
                                                  title: Text(
                                                    'Checks'.tr,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Constants
                                                              .textColor3,
                                                    ),
                                                  ),
                                                  tail: Container(
                                                    margin:
                                                        const EdgeInsetsDirectional
                                                            .only(end: 10),
                                                    child: Text(
                                                      '${data.customerIdModel.checks == null ? 0 : data.customerIdModel.checks!.length}',
                                                      style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.grey
                                                            : Constants
                                                                .textColor2,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  )),
                                              const Divider(
                                                height: 2,
                                                thickness: 0.2,
                                                indent: 20,
                                                endIndent: 20,
                                              ),
                                              DefaultItemWidget.smallIcon(
                                                  height: 40,
                                                  width: 40,
                                                  icon: SvgPicture.asset(
                                                      'assets/images/sal.svg'),
                                                  title: Text(
                                                    'High end'.tr,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Constants
                                                              .textColor3,
                                                    ),
                                                  ),
                                                  tail: Container(
                                                    margin:
                                                        const EdgeInsetsDirectional
                                                            .only(end: 10),
                                                    child: Text(
                                                      '${data.customerIdModel.accountInfo!.maxDebit ?? 0}',
                                                      style: TextStyle(
                                                        color: Get.isDarkMode
                                                            ? Colors.grey
                                                            : Constants
                                                                .textColor2,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  )),
                                              const Divider(
                                                height: 2,
                                                thickness: 0.2,
                                                indent: 20,
                                                endIndent: 20,
                                              ),
                                              DefaultItemWidget.smallIcon(
                                                  height: 40,
                                                  width: 40,
                                                  onTap: () {
                                                    Get.to(VisitsScreen(
                                                      cusomerId: widget
                                                          .customer.id
                                                          .toString(),
                                                    ));
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 19,
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                  title: Text(
                                                    'Last visit'.tr,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Constants
                                                              .textColor3,
                                                    ),
                                                  ),
                                                  tail: Container(
                                                    margin:
                                                        const EdgeInsetsDirectional
                                                            .only(end: 10),
                                                    child: Text(
                                                      data.customerIdModel
                                                                  .updatedAt ==
                                                              null
                                                          ? '_'
                                                          : outputDate,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Get.isDarkMode
                                                            ? Colors.grey
                                                            : Constants
                                                                .textColor2,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomButton(
                                              height: 50.h,
                                              width: 115.w,
                                              onTap: () async {
                                                if (GetStorage()
                                                        .read("accountNo") ==
                                                    data.customerIdModel.id) {
                                                  Get.snackbar(
                                                      'Portfolio Financial System'
                                                          .tr,
                                                      'There is already a visit'
                                                          .tr,
                                                      colorText: Constants
                                                          .primaryColor,
                                                      backgroundColor:
                                                          Colors.white);
                                                } else if (GetStorage()
                                                        .read("accountNo") ==
                                                    null) {
                                                  return await buildAwesomeDialog(
                                                          context, data)
                                                      .show();
                                                } else if (GetStorage()
                                                        .read("accountNo") !=
                                                    data.customerIdModel.id) {
                                                  Get.snackbar(
                                                      'Portfolio Financial System'
                                                          .tr,
                                                      'You have to finish the previous round to be able to start new rounds.'
                                                          .tr,
                                                      colorText: Constants
                                                          .primaryColor,
                                                      backgroundColor:
                                                          Colors.white);
                                                }
                                              },
                                              text: 'started to visit'.tr,
                                              color: Get.isDarkMode
                                                  ? Colors.blueGrey
                                                  : Constants.primaryColor,
                                              borderColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              // DefaultItemWidget(
                                              //     height: 50.h,
                                              //     width: 45.w,
                                              //     onTap: () async {
                                              //       if (GetStorage().read(
                                              //               "accountNo") ==
                                              //           data.customerIdModel
                                              //               .id) {
                                              //         Get.snackbar(
                                              //             'Portfolio Financial System'
                                              //                 .tr,
                                              //             'There is already a visit'
                                              //                 .tr,
                                              //             colorText: Constants
                                              //                 .primaryColor,
                                              //             backgroundColor:
                                              //                 Colors.white);
                                              //       } else if (GetStorage()
                                              //               .read(
                                              //                   "accountNo") ==
                                              //           null) {
                                              //         return await buildAwesomeDialog(
                                              //                 context, data)
                                              //             .show();
                                              //       } else if (GetStorage()
                                              //               .read(
                                              //                   "accountNo") !=
                                              //           data.customerIdModel
                                              //               .id) {
                                              //         Get.snackbar(
                                              //             'Portfolio Financial System'
                                              //                 .tr,
                                              //             'You have to finish the previous round to be able to start new rounds.'
                                              //                 .tr,
                                              //             colorText: Constants
                                              //                 .primaryColor,
                                              //             backgroundColor:
                                              //                 Colors.white);
                                              //       }
                                              //     },
                                              //     icon: const Icon(
                                              //       Icons.av_timer_outlined,
                                              //       color:
                                              //           Constants.primaryColor,
                                              //       size: 28,
                                              //     ),
                                              //     title: Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment
                                              //               .start,
                                              //       children: [
                                              //         Text(
                                              //           'started to visit'.tr,
                                              //           style: TextStyle(
                                              //             color: Get.isDarkMode
                                              //                 ? Colors.white
                                              //                 : Constants
                                              //                     .textColor2,
                                              //             fontSize: 16.sp,
                                              //             fontWeight:
                                              //                 FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //         const SizedBox(
                                              //           height: 4,
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     tail: const Icon(
                                              //       Icons.arrow_forward_ios,
                                              //       color: Colors.grey,
                                              //       size: 18,
                                              //     )),
                                              // const Divider(
                                              //   height: 2,
                                              //   thickness: 0.2,
                                              //   indent: 10,
                                              //   endIndent: 10,
                                              // ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              getUser()!.welcomeUserPermissions![
                                                      "sales_invoices.print"]!
                                                  ? DefaultItemWidget(
                                                      height: 55.h,
                                                      width: 55.w,
                                                      onTap: () {
                                                        Get.to(() =>
                                                            InventoryScreen(
                                                              id: 1,
                                                              customerIdModel: data
                                                                  .customerIdModel,
                                                              customer: widget
                                                                  .customer,
                                                            ));
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .description_outlined,
                                                        color: Constants
                                                            .primaryColor,
                                                        size: 28,
                                                      ),
                                                      title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Sales invoices'.tr,
                                                            style: TextStyle(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Constants
                                                                      .textColor2,

                                                              fontSize: 18.sp,
                                                              //     color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'You can create a cash sales invoice and receivables for customers'
                                                                .tr,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.grey
                                                                  : Constants
                                                                      .textColor3,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      tail: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.grey,
                                                        size: 21,
                                                      ))
                                                  : const SizedBox(),
                                              const Divider(
                                                height: 2,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              DefaultItemWidget(
                                                  height: 55.h,
                                                  width: 55.w,
                                                  onTap: () {
                                                    Get.to(
                                                        () => CashReceiptScreen(
                                                              customerIdModel: data
                                                                  .customerIdModel,
                                                              customer: widget
                                                                  .customer,
                                                            ));
                                                  },
                                                  icon: const Icon(
                                                    Icons.receipt_long_outlined,
                                                    color:
                                                        Constants.primaryColor,
                                                    size: 28,
                                                  ),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Cash Receipt'.tr,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Constants
                                                                  .textColor2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Issuance of receipt vouchers to clients in cash or bank checks'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.grey
                                                              : Constants
                                                                  .textColor3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  tail: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 21,
                                                  )),
                                              const Divider(
                                                height: 10,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              DefaultItemWidget(
                                                  height: 55.h,
                                                  width: 55.w,
                                                  onTap: () {
                                                    Get.to(InventoryScreen(
                                                      id: 2,
                                                      customerIdModel:
                                                          data.customerIdModel,
                                                      customer: widget.customer,
                                                    ));
                                                  },
                                                  icon: const Icon(
                                                      Icons
                                                          .request_page_outlined,
                                                      size: 28,
                                                      color: Constants
                                                          .primaryColor),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Purchase order'.tr,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Constants
                                                                  .textColor2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Request to purchase products and send them to management for follow-up'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.grey
                                                              : Constants
                                                                  .textColor3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  tail: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 21,
                                                  )),
                                              const Divider(
                                                height: 10,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              getUser()!.welcomeUserPermissions![
                                                      "purchase_invoices.create"]!
                                                  ? DefaultItemWidget(
                                                      height: 55.h,
                                                      width: 55.w,
                                                      onTap: () {
                                                        Get.to(() =>
                                                            AccountStatementScreen(
                                                              customerIdModel: data
                                                                  .customerIdModel,
                                                            ));
                                                      },
                                                      icon: SvgPicture.asset(
                                                          'assets/images/receipt.svg'),
                                                      title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Account statement'
                                                                .tr,
                                                            style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : Constants
                                                                      .textColor2,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'A statement of account for the customer within a certain period of time and printed'
                                                                .tr,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.grey
                                                                  : Constants
                                                                      .textColor3,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      tail: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.grey,
                                                        size: 21,
                                                      ))
                                                  : const SizedBox(),
                                              const Divider(
                                                height: 10,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              DefaultItemWidget(
                                                  onTap: () {
                                                    Get.to(InventoryScreen(
                                                      id: 3,
                                                      customerIdModel:
                                                          data.customerIdModel,
                                                      customer: widget.customer,
                                                    ));
                                                  },
                                                  height: 55.h,
                                                  width: 55.w,
                                                  icon: const Icon(
                                                    Icons.receipt_outlined,
                                                    color:
                                                        Constants.primaryColor,
                                                    size: 28,
                                                  ),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Sales returns'.tr,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Constants
                                                                  .textColor2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Returning materials to customers for their accounts, either cash or accounts receivable'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.grey
                                                              : Constants
                                                                  .textColor3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  tail: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 21,
                                                  )),
                                              const Divider(
                                                height: 10,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              DefaultItemWidget(
                                                  height: 55.h,
                                                  width: 55.w,
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const InfoImagesScreen());
                                                  },
                                                  icon: const Icon(
                                                      Icons
                                                          .camera_rear_outlined,
                                                      color: Constants
                                                          .primaryColor,
                                                      size: 28),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Take a picture of the information'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Constants
                                                                  .textColor2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'You can take photos of customer information'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.grey
                                                              : Constants
                                                                  .textColor3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  tail: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 21,
                                                  )),
                                              const Divider(
                                                height: 10,
                                                thickness: 0.2,
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              DefaultItemWidget(
                                                  onTap: () {
                                                    updateClientAction(context,
                                                        data.customerIdModel!);
                                                  },
                                                  icon: const Icon(Icons.update,
                                                      color: Constants
                                                          .primaryColor,
                                                      size: 28),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Update client address'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Constants
                                                                  .textColor2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'You can update the clients address through GPS'
                                                            .tr,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Get.isDarkMode
                                                              ? Colors.grey
                                                              : Constants
                                                                  .textColor3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 55.h,
                                                  width: 55.w,
                                                  tail: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 21,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                    }))));
  }

  AwesomeDialog buildAwesomeDialog(BuildContext context, CustomerCubit data) {
    return AwesomeDialog(
      dialogBackgroundColor: Get.isDarkMode ? DARK_GREY : Colors.white,
      context: context,
      padding: const EdgeInsets.all(20),
      btnCancel: Row(
        children: [
          InkWell(
            onTap: () {
              AddRepVisitsModel repVisitModel = AddRepVisitsModel();

              repVisitModel.id = data.customerIdModel.accountInfo!.accountId;
              repVisitModel.accountId =
                  data.customerIdModel.accountInfo!.accountId;
              repVisitModel.salesmanId =
                  data.customerIdModel.accountInfo!.salesmanNo.toString();
              repVisitModel.latitude =
                  double.tryParse(data.customerIdModel.accountInfo!.latitude!);
              repVisitModel.longitude =
                  double.tryParse(data.customerIdModel.accountInfo!.longitude!);
              repVisitModel.userId = getUser()!.userCompanies!.first.userId;
              repVisitModel.debitAccountId =
                  data.customerIdModel.accountInfo!.accountId;
              setState(() {});
              RepVisitsCubit().addVisit(repVisitModel).then((value) {
                DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

                setState(() {
                  GetStorage()
                      .write("createdAt", dateFormat.format(DateTime.now()));
                  GetStorage().write("isVisit", true);
                  GetStorage().write("accountNo", data.customerIdModel.id);
                  GetStorage()
                      .write("visitName", data.customerIdModel.accountName);
                });
                Navigator.of(context).pop();
              });
            },
            child: Text(
              'started to visit'.tr,
              style: const TextStyle(
                  color: Constants.primaryColor, fontWeight: FontWeight.w600),
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
              'Cancel'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Portfolio Financial System'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Do you want to open a new visit?'.tr,
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
    );
  }

  updateClientAction(BuildContext context, CustomerIdModel customer) {
    CustomerCubit().getLocation().then((value) {
      CreateCustomerModel y = CreateCustomerModel();

      y.id = customer.id;
      y.accountName = customer.accountName;
      y.address = value;

      CustomerCubit().updateClientAddress(y, context);
    }).catchError((onError) {});
  }

  AppBar buildAppBar() {
    return AppBar(
      //    backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1,
      title: Text(
        'Customer details'.tr,
        style: const TextStyle(
            //color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
          onPressed: () {
            Get.to(BottomNavigationScreen(
              index: 1,
            ));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          )),
      actions: [
        IconButton(
            onPressed: () {
              callAction();
            },
            icon: const Icon(
              Icons.call,
              color: Colors.blue,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.location_on,
              color: Colors.blue,
            )),
      ],
    );
  }

  callAction() async {
    widget.customer!.mobileNo!.isNotEmpty
        ? await launchUrl(Uri.parse("tel://${widget.customer!.mobileNo!}"))
        : Get.snackbar(
            'no number'.tr,
            'this user didnt have number'.tr,
            backgroundColor: Get.isDarkMode ? Colors.white70 : Colors.grey,
            colorText: Get.isDarkMode ? Colors.black54 : Colors.black87,
          );
  }

// Future<void> getUserLocation() async {
//   Location location = Location.instance;
//   bool isGpsEnabled = await location.requestService();
//   if (!isGpsEnabled) {
//     return;
//   }

//   PermissionStatus permissionStatus = await location.requestPermission();

//   if (permissionStatus == PermissionStatus.denied ||
//       permissionStatus == PermissionStatus.deniedForever) {
//     return;
//   }

//   LocationData data = await location.getLocation();   }
}
