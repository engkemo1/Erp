import 'package:firstprojects/view/screens/customers/inventory_transaction/inventory_transaction_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../models/customers/create_customer_model.dart';
import '../../../../models/invoices_model/invoices_model.dart';
import '../../../../models/selected_bottom_sheet_model/PayType.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/empty_component.dart';

class ResultSearchInvoices extends StatefulWidget {
  ResultSearchInvoices(
      {Key? key,
      required this.reportItems,
      this.onTap,
      required this.sum,
      required this.sum1,
      required this.sum2,
      required this.id})
      : super(key: key);

  final List<InvoicesModel> reportItems;
  final int id;
  final double sum;
  final double sum1;
  final double sum2;

  CustomerIdModel? customer;
  final void Function()? onTap;

  @override
  State<ResultSearchInvoices> createState() => _ResultSearchInvoicesState();
}

class _ResultSearchInvoicesState extends State<ResultSearchInvoices> {
  var customerCont = CustomerCubit();
  List<PayType> payTypes = [];
  double sum = 0.00;
  double cheque = 0.00;

  List<CreateCustomerModel> customers = [];
  @override
  void initState() {
    customerCont.getAllCustomers(1).then((value) => customers.addAll(value));

    CustomerCubit().initialize().then((value) {
      payTypes.addAll(value.payTypes!);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.reportItems.isEmpty
            ? Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
                child: EmptyComponent(
                  text: 'There are no reports'.tr,
                ))
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                        children: List.generate(
                            widget.reportItems.length,
                            (index) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var customer = customers.firstWhere(
                                            (element) =>
                                                element.accountName ==
                                                widget.reportItems[index]
                                                    .accountName);

                                        widget.onTap ??
                                            Get.to(
                                                InventoryTransactionDetailsScreen(
                                              isReport: true,
                                              payTypes: payTypes,
                                              id: widget.id,
                                              accountName: customer.accountName,
                                              accountNo:
                                                  customer.accountNo.toString(),
                                              invoiceId: widget
                                                  .reportItems[index].id
                                                  .toString(),
                                            ));
                                      },
                                      child: ListTile(
                                        leading: Container(
                                            decoration: BoxDecoration(
                                                color: Get.isDarkMode
                                                    ? Colors.white12
                                                    : Constants.textColor
                                                        .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.receipt,
                                              size: 25,
                                              color: Get.isDarkMode
                                                  ? Colors.black54
                                                  : Constants.primaryColor,
                                            )),
                                        trailing: Text(
                                          widget
                                              .reportItems[index].totalAfterTax!
                                              .toStringAsFixed(3),
                                          style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? Colors.blueGrey
                                                  : Constants.primaryColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        title: Text(
                                          "${widget.reportItems[index].accountName!.toString()} #${widget.reportItems[index].transactionNo.toString()}",
                                          style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Constants.textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_month,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              widget.reportItems[index]
                                                  .transactionDate
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Get.isDarkMode
                                                    ? Colors.grey
                                                    : Constants.textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                    )
                                  ],
                                ))),
                  ),
                  Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Color(0xff0E60B1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Total cash'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(widget.sum2.toStringAsFixed(3),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Total receivables'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(widget.sum1.toStringAsFixed(3),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Total'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(widget.sum.toStringAsFixed(3),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ));
  }
}
