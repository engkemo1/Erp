import 'package:firstprojects/view/screens/app_screens/customers_screens/customers_screen.dart';
import 'package:firstprojects/view/screens/reports/results_reports/results_invoices.dart';
import 'package:firstprojects/view/screens/transactions/salesman_screen/salesman_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/cubit/reports_cubit/report_cubit.dart';
import '../../../models/invoices_model/invoices_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/date_entry_field.dart';
import '../../widgets/empty_component.dart';
import '../../widgets/entry_field_widget.dart';
import '../../widgets/app_bar_widget/rounded_app_bar.dart';
import '../lost_connection_screen.dart';

class InventoryReportsScreen extends StatefulWidget {
  const InventoryReportsScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _InventoryReportsScreenState createState() => _InventoryReportsScreenState();
}

class _InventoryReportsScreenState extends State<InventoryReportsScreen> {
  final TextEditingController _dateControllerFrom = TextEditingController();
  final TextEditingController _dateControllerTo = TextEditingController();

  TextEditingController delegateController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  var reportController = ReportsCubit();
  double sum = 0;
  double sum1 = 0;
  double sum2 = 0;

  List<InvoicesModel> inventoryModelList = [];

  List list = [];
  String? name, agentName;
  int? id, agentId;
  bool isTap = false;

  String _getTitle() {
    return widget.id == 1
        ? 'Sales Invoice Report'.tr
        : widget.id == 3
            ? 'Sales Return Report'.tr
            : 'Purchase order report'.tr;
  }

  String getSubTitle() {
    return widget.id == 1
        ? 'Sales transactions report detailing cash and receivables'.tr
        : widget.id == 3
            ? 'Report cash receipts and checks within a specific time period'.tr
            : '';
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        icon: SvgPicture.asset('assets/images/mdpi.svg'),
        title: _getTitle(),
        subtitle: getSubTitle(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  Get.isDarkMode ? DARK_GREY3 : Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(const CustomersScreen(
                                    id: 1,
                                  ))?.then((value) {
                                    if (value != null) {
                                      setState(() {
                                        agentId = value[1];
                                        agentName = value[0];
                                      });
                                    }
                                  });
                                },
                                child: EntryField(
                                  controller: customerController
                                    ..text = agentName ?? '',
                                  filled: true,
                                  enabled: false,
                                  icon: const Icon(
                                    Icons.person_outline,
                                    size: 30,
                                  ),
                                  hasTitle: true,
                                  hint: 'All'.tr,
                                  label: 'Customer name'.tr,
                                  isCenter: false,
                                  hasBorder: true,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const SalesmanScreen(
                                    isScreen: false,
                                  ))?.then((value) {
                                    if (value != null) {
                                      setState(() {
                                        name = value[1];
                                        id = value[0];
                                      });
                                    }
                                  });
                                },
                                child: EntryField(
                                  controller: delegateController
                                    ..text = name ?? '',
                                  filled: true,
                                  enabled: false,
                                  icon: const Icon(
                                    Icons.person_outline,
                                    size: 30,
                                  ),
                                  hasTitle: true,
                                  hint: 'All'.tr,
                                  label: 'Delegate name'.tr,
                                  isCenter: false,
                                  hasBorder: true,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: DateEntryField(
                                      filled: true,
                                      label: 'From the date of'.tr,
                                      textEditingController:
                                          _dateControllerFrom,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: DateEntryField(
                                      filled: true,
                                      label: 'To date'.tr,
                                      textEditingController: _dateControllerTo,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.w,
                                ),
                                child: CustomButton(
                                  height: 45.h,
                                  color: Constants.primaryColor,
                                  onTap: () {
                                    final String _selectedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(DateTime.now());
                                    inventoryModelList.clear();
                                    reportController
                                        .getInvoices(
                                            widget.id,
                                            agentId,
                                            _dateControllerTo.text == ''
                                                ? _selectedDate
                                                : _dateControllerTo.text,
                                            _dateControllerFrom.text == ''
                                                ? _selectedDate
                                                : _dateControllerFrom.text,
                                            id.toString())
                                        .then((value) {
                                      inventoryModelList = value;
                                      sum1 = 0;
                                      sum2 = 0;
                                      for (var element in inventoryModelList) {
                                        if (element.payType!.id == 1) {
                                          sum1 += element.totalAfterTax;
                                        } else if (element.payType!.id == 2) {
                                          sum2 += element.totalAfterTax;
                                        }

                                        sum = sum +
                                            element.totalAfterTax!.toDouble();
                                      }
                                      isTap = true;
                                      setState(() {});
                                    });
                                  },
                                  text: 'Search'.tr,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isTap == true
                            ? ResultSearchInvoices(
                                sum1: sum1,
                                sum2: sum2,
                                id: widget.id,
                                reportItems: inventoryModelList,
                                sum: sum,
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Get.isDarkMode
                                        ? DARK_GREY3
                                        : Colors.white),
                                child: EmptyComponent(
                                  text: 'Choose the date to show the movements'
                                      .tr,
                                ))
                      ])))
              : LostConnectionWidget(connected);
        },
        child: const SizedBox(),
      ),
    );
  }
}
