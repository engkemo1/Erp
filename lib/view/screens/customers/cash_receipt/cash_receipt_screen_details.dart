import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstprojects/controllers/pdf_services/pdf_service.dart';
import 'package:firstprojects/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../controllers/cubit/cash_receipt_cubit/cash_receipt_cubit.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../models/cash receipt model/cash_receipt_model.dart';
import '../../../widgets/customers/account_widget.dart';
import '../../pdf_view/cash_receipt_pdf.dart';
import '../../../../models/Customers/customer_id_model.dart';
import '../../../../models/customers/create_customer_model.dart';
import '../../../../models/selected_bottom_sheet_model/bank_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/storage.dart';
import '../../../widgets/app_bar_widget/custom_app_bar.dart';
import '../../../widgets/bottom_navigation_widget.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/date_entry_field.dart';
import '../../../widgets/default_item_widget.dart';
import '../../../widgets/entry_field_widget.dart';
import '../../../widgets/selectable_entry_field.dart';
import '../visit_screen/visit_details_screen.dart';
import 'cash_receipt_screen.dart';

//  'salesmanName': '${authController.userSavedData.userCompanies.first.salesman!.salesmanNo}',
class CashReceiptScreenDetails extends StatefulWidget {
  CashReceiptScreenDetails(
      {super.key,
      this.customerIdModel,
      this.cashReciept,
      this.customer,
      this.company,
      this.id,
      this.isReport,
      this.banks});

  int? id;
  bool? isReport;
  List<BanksModel>? banks;
  CreateCustomerModel? customer;
  CustomerIdModel? customerIdModel;
  CashReceiptModel? cashReciept;
  UserCompany? company;

  @override
  _CashReceiptScreenDetailsState createState() =>
      _CashReceiptScreenDetailsState();
}

class _CashReceiptScreenDetailsState extends State<CashReceiptScreenDetails> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool visibility = false;
  bool isvisible = false;
  bool isExpanded = false;
  List<Cheques> chequeList = [];
  CashReceiptModel cashReceiptModel = CashReceiptModel();
  var customersController = CustomerCubit();
  TextEditingController cash = TextEditingController(text: '0.00');
  TextEditingController check = TextEditingController(text: '0.00');
  TextEditingController dateController = TextEditingController();
  TextEditingController chequeNoController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController chequePersonController = TextEditingController();
  TextEditingController chequeAmountController = TextEditingController();
  TextEditingController chequeDateController = TextEditingController();
  TextEditingController statementController = TextEditingController();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? chequeNo, chequeDate, chequePerson, statement, bankName;
  double sum = 0;
  static const platform = MethodChannel('com.example.firstprojects/print');
  var accountName;
  List<BanksModel> banks = [];
  final _focusNode = FocusNode();
  bool isConfirm = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        cash.selection =
            TextSelection(baseOffset: 0, extentOffset: cash.text.length);
      }
    });
    if (widget.isReport != true) {
      banks = widget.banks!;
    }
    if (widget.id != null) {
      getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(
        color:
            getUser()!.welcomeUserPermissions!["journal_receivable.update"] ==
                    true
                ? null
                : Colors.grey,
        onTapAdd: () {
          if (getUser()!.welcomeUserPermissions!["journal_receivable.update"] ==
                  true &&
              widget.isReport == null) {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              builder: (BuildContext context) {
                return Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 40),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    height: 600.h,
                    child: addCheque(context));
              },
            );
          }
        },
        onTap: () async {
          if (getUser()!.welcomeUserPermissions!["journal_receivable.update"] ==
              true) {
            if (statementController.text.isNotEmpty) {
              return await buildAwesomeDialogConfirmation(context).show();
            } else {
              Get.snackbar(
                'please fill all fields'.tr,
                '',
                backgroundColor: Colors.white,
                colorText: Constants.textColor2,
              );
            }
          } else {
            Get.snackbar(
              'you not have permission to add cheque'.tr,
              '',
              backgroundColor: Colors.white,
              colorText: Constants.textColor2,
            );
          }
        },
      ),
      appBar: CustomAppBar(
          title: 'Receipt voucher'.tr,
          leading: Icons.arrow_back_ios,
          trailing: widget.id != null || isConfirm == true ? Icons.print : null,
          onTap: () {
            if (widget.isReport == true) {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CashReceiptScreen(
                            customerIdModel: widget.customerIdModel!,
                            customer: widget.customer,
                          )));
            }
          },
          onTapTrailing: () {
            if (getUser()!
                    .welcomeUserPermissions!["journal_receivable.print"] ==
                true) {
              buildDefaultDialogSelectOption();
            }
          },
          trailing2:
              getUser()!.welcomeUserPermissions!["journal_receivable.delete"] ==
                              true &&
                          widget.id != null ||
                      isConfirm == true
                  ? Icons.delete
                  : null,
          onTapTrailing2:
              getUser()!.welcomeUserPermissions!["journal_receivable.delete"] ==
                      true
                  ? () async {
                      return await buildAwesomeDialogDelete(context).show();
                    }
                  : null),
      body: WillPopScope(
          onWillPop: () async {
            if (widget.isReport == true) {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CashReceiptScreen(
                            customerIdModel: widget.customerIdModel!,
                            customer: widget.customer,
                          )));
            }

            return false;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetStorage().read('accountNo') != null
                      ? InkWell(
                          onTap: () {
                            Get.to(() => VisitDetailsScreen());
                          },
                          child: AccountWidget(),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? DARK_GREY2
                                : const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Column(
                              children: [
                                SizedBox(height: 14.h),
                                DefaultItemWidget(
                                  width: 55.w,
                                  height: 55.h,
                                  icon: SvgPicture.asset(
                                      'assets/images/clients.svg'),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.customerIdModel != null
                                            ? widget
                                                .customerIdModel!.accountName!
                                            : widget.customer!.accountName!,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Constants.textColor2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        '${widget.customerIdModel != null ? widget.customerIdModel!.accountNo! : widget.customer!.accountNo!}',
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.grey
                                              : Constants.textColor3,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Divider(
                                  height: 0.h,
                                  thickness: 0.1,
                                  color: Colors.black38,
                                  indent: 15.w,
                                  endIndent: 15.w,
                                ),
                                DefaultItemWidget.smallIcon(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 8.h),
                                  icon: SvgPicture.asset(
                                    'assets/images/report.svg',
                                    width: 20.w,
                                    color: Constants.primaryColor,
                                  ),
                                  height: 40,
                                  width: 40,
                                  title: Text(
                                    'Arrest warrant number'.tr,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor3,
                                    ),
                                  ),
                                  tail: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        widget.id != null
                                            ? widget.cashReciept!.bondNo
                                                .toString()
                                            : '-',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Get.isDarkMode
                                                ? Colors.grey
                                                : Constants.textColor2,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Divider(
                                  height: 0.45.h,
                                  thickness: 0.1,
                                  color: Colors.black38,
                                  indent: 15.w,
                                  endIndent: 15.w,
                                ),
                                DefaultItemWidget.smallIcon(
                                  onTap: () {},
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 8.h),
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Constants.primaryColor,
                                    size: 20,
                                  ),
                                  title: Text(
                                    'Date'.tr,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Constants.textColor3,
                                    ),
                                  ),
                                  tail: Text(
                                    widget.id == null
                                        ? date
                                        : widget.cashReciept!.bondDate
                                            .toString(),
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.grey
                                            : Constants.textColor2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                // Divider(
                                //   height: 0.45.h,
                                //   thickness: 0.4,
                                //   color: Colors.black38,
                                //   indent: 15.w,
                                //   endIndent: 15.w,
                                // ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 10.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: EntryField(
                                              controller: cash,
                                              focusNode: _focusNode,
                                              inputType: TextInputType.number,
                                              label: 'The cash value'.tr,
                                              hasTitle: true,
                                              enabled: widget.id != null
                                                  ? getUser()!.welcomeUserPermissions![
                                                              "journal_receivable.update"] ==
                                                          true
                                                      ? true
                                                      : false
                                                  : true,
                                              isCenter: true,
                                              hasBorder: true,
                                              hint: 'The cash value'.tr,
                                              filled: false,
                                              labelFontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: EntryField(
                                              enabled: false,
                                              controller: check
                                                ..text = chequeList.isEmpty
                                                    ? widget.id == null
                                                        ? sum.toStringAsFixed(2)
                                                        : sum.toStringAsFixed(3)
                                                    : sum.toStringAsFixed(3),
                                              inputType: TextInputType.number,
                                              hasTitle: true,
                                              isCenter: true,
                                              filled: false,
                                              hasBorder: true,
                                              hint: 'Check value'.tr,
                                              label: 'Check value'.tr,
                                              labelFontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'To add checks, click on + at the bottom of the list'
                                            .tr,
                                        style: GoogleFonts.ibmPlexSansArabic(
                                          color: Colors.red,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: 3.h),
                                      EntryField(
                                        controller: statementController,
                                        hasTitle: true,
                                        isCenter: false,
                                        filled: false,
                                        enabled: widget.id != null
                                            ? getUser()!.welcomeUserPermissions![
                                                        "journal_receivable.update"] ==
                                                    true
                                                ? true
                                                : false
                                            : true,
                                        hasBorder: true,
                                        hint: 'Statement'.tr,
                                        label: 'Statement *'.tr,
                                        labelFontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildItemWidget(chequeList, context)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<dynamic> buildDefaultDialogSelectOption() {
    return Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (_) {
          return SizedBox(
              height: 160,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                          child: Text('Select Options'.tr,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.primaryColor))),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.picture_as_pdf_rounded,
                                  color: Constants.primaryColor),
                              const SizedBox(
                                width: 9,
                              ),
                              Text('Pdf Export'.tr,
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                          onTap: () async {
                            getformattedTime(TimeOfDay time) {
                              return '${time.hour}:${time.minute} ${time.period.toString().split('.')[1]}';
                            }

                            TimeOfDay initialTime = TimeOfDay.now();

                            var date =
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())}  ${getformattedTime(initialTime)}';

                            final pdfFile = await PdfInvoice.generate(
                                customer: widget.customerIdModel!,
                                invoice: widget.id == null
                                    ? cashReceiptModel
                                    : widget.cashReciept!,
                                userModel: getUser()!,
                                date: date);
                            PdfApi.openFile(pdfFile);
                          }),
                      const Divider(
                        indent: 2,
                      ),
                      InkWell(
                          onTap: () {
                            // handlePrintAction();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.local_print_shop_outlined,
                                  color: Constants.primaryColor),
                              const SizedBox(
                                width: 9,
                              ),
                              Text(
                                'Printer'.tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ))
                    ],
                  )));
        }));
  }

  AwesomeDialog buildAwesomeDialogConfirmation(BuildContext context) {
    return AwesomeDialog(
      dialogBackgroundColor: Get.isDarkMode ? DARK_GREY : Colors.white,
      context: context,
      padding: const EdgeInsets.all(20),
      btnCancel: Row(
        children: [
          InkWell(
            onTap: () async {
              String _selectedDate =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              var id = widget.customerIdModel!.id!;

              CashReceiptModel cashReceiptModelItem = CashReceiptModel();

              if (widget.id == null) {
                cashReceiptModelItem = CashReceiptModel(
                    visitId: GetStorage().read("visitId"),
                    bondNo: 1,
                    bondType: 2,
                    accountBranchId: 0,
                    bondDate: _selectedDate,
                    branchNo: 1,
                    exchange: 1,
                    foreignPrice: 0,
                    bondId: 0,
                    departmentNo: 1,
                    salesmanNo: 80,
                    cash: int.tryParse(cash.text)!,
                    cheque: sum.toInt(),
                    debitAccountId: id,
                    creditAccountId: id,
                    statement: statementController.text,
                    latitude: 0,
                    longitude: 0,
                    source: 'mobile',
                    serial: 0,
                    cheques: chequeList);
              } else {
                cashReceiptModelItem = CashReceiptModel(
                    id: widget.cashReciept!.id,
                    accountBranchId: 0,
                    uuid: widget.cashReciept!.uuid,
                    visitId: GetStorage().read("visitId"),
                    bondNo: widget.cashReciept!.bondNo,
                    bondType: widget.cashReciept!.bondType,
                    departmentNo: 1,
                    bondDate: widget.cashReciept!.bondDate,
                    bondId: widget.cashReciept!.bondId,
                    salesmanNo: widget.cashReciept!.salesmanNo,
                    cash: double.tryParse(cash.text)!.toInt(),
                    cheque: sum.toInt(),
                    exchange: 1,
                    foreignPrice: 0,
                    debitAccountId: id,
                    creditAccountId: id,
                    statement: statementController.text,
                    latitude: 0,
                    longitude: 0,
                    source: 'mobile',
                    serial: 0,
                    cheques: chequeList);
              }

              if (widget.id == null) {
                CashReceiptCubit()
                    .addCashReceipt(
                        widget.customerIdModel!.id!, cashReceiptModelItem)
                    .then((value) {
                  CashReceiptCubit()
                      .getCashReceiptById(value.uuid.toString())
                      .then((value2) => setState(() {
                            cashReceiptModel = value2;
                          }));
                  isConfirm = true;
                  setState(() {});
                });
              } else if (widget.id == 1 || widget.id != null) {
                CashReceiptCubit().updateCashReceipt(
                    widget.customerIdModel!.id!, cashReceiptModelItem);
              }

              Navigator.pop(context);
            },
            child: Text(
              'YES'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500),
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
                  color: Constants.primaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirmation'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Are you sure you want to add item'.tr,
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

  handlePrintAction() async {
    var totalAmount = widget.cashReciept!.cheque! + widget.cashReciept!.cash!;

    try {
      var result = await platform.invokeMethod('cashReceipt', {
        'bondNo': widget.cashReciept!.bondNo.toString(),
        'bondDate': widget.cashReciept!.bondDate!.toString(),
        'checkAmount': widget.cashReciept!.cheque!.toStringAsFixed(3),
        'totalAmount': totalAmount,
        'cashAmount': widget.cashReciept!.cash!.toStringAsFixed(3),
        'checks': widget.cashReciept!.cheque!.toStringAsFixed(3),
        'salesmanPhoneNumber': '',
        'macAddress': '${getUser()!.userCompanies!.first.printerMacAddress}',
        'companyName':
            '${getUser()!.userCompanies!.first.company!.companyName}',
        'salesmanName': widget.customer!.salesman!.name,
        'companyPhoneNumber':
            '${getUser()!.userCompanies!.first.company!.phoneNumber}',
        'companyTaxNumber':
            '${getUser()!.userCompanies!.first.company!.taxNumber}',
        'creditAccountName': accountName,
        'statement': widget.cashReciept!.statement.toString(),
        'companyAddress':
            '${getUser()!.userCompanies!.first.company!.companyAddress}',
      }).then((value) => Get.defaultDialog(
          onConfirm: () {
            Get.back();
          },
          content: Center(
            child: Text('The information has been sent to the printer.'.tr),
          )));
    } catch (ex) {
      print(ex);
    }
  }

  buildAwesomeDialogDelete(BuildContext context) {
    return AwesomeDialog(
      dialogBackgroundColor: Get.isDarkMode ? DARK_GREY : Colors.white,
      context: context,
      padding: const EdgeInsets.all(20),
      btnCancel: Row(
        children: [
          InkWell(
            onTap: () {
              CashReceiptCubit()
                  .deleteCashReceipt(
                      widget.id == null
                          ? cashReceiptModel.uuid
                          : widget.cashReciept!.uuid,
                      widget.customerIdModel != null
                          ? widget.customerIdModel!.uuid!
                          : widget.customer!.id!,
                      context)
                  .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CashReceiptScreen(
                                customerIdModel: widget.customerIdModel!,
                                customer: widget.customer,
                              ))));
            },
            child: Text(
              'YES'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500),
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
                  color: Constants.primaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Delete'.tr,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white70 : Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Are you sure you want to remove item'.tr,
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

  buildItemWidget(List<Cheques> chequeList, BuildContext context) {
    return Container(
        child: chequeList.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 8),
                            child: Column(
                              children: List.generate(
                                chequeList.length,
                                (index) {
                                  return InkWell(
                                      onTap: () {
                                        if (widget.id != null) {
                                          if (getUser()!
                                                      .welcomeUserPermissions![
                                                  "journal_receivable.update"] ==
                                              true) {
                                            onTapChequeListItem(index);
                                          }
                                        } else {
                                          onTapChequeListItem(index);
                                        }
                                      },
                                      child: DefaultItemWidget(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        icon: const Icon(
                                            Icons.receipt_long_outlined,
                                            color: Constants.primaryColor,
                                            size: 28),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${chequeList[index].bankName} ${chequeList[index].chequeNo}#'
                                                        .tr,
                                                    style: TextStyle(
                                                        color: !Get.isDarkMode
                                                            ? Colors
                                                                .blue.shade900
                                                            : Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.sp),
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
                                                  chequeList[index]
                                                      .chequeDate
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: !Get.isDarkMode
                                                        ? Colors.blue.shade800
                                                        : Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        tail: Text(
                                          chequeList[index]
                                              .chequeAmount!
                                              .toStringAsFixed(3),
                                          style: TextStyle(
                                            color: Colors.blue[600],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff113d6b),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'number of checks'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  chequeList.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Total Checks'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  sum.toStringAsFixed(3),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ));
  }

  editCheque(int index, BuildContext context) {
    return SafeArea(
      child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      chequeNoController.clear();
                      chequeAmountController.clear();
                      chequePersonController.clear();
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel,
                        color: Get.isDarkMode
                            ? Colors.blueGrey
                            : Constants.textColor2,
                        size: 30),
                  ),
                ),
                Text(
                  'Modify'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                EntryField(
                  hasTitle: true,
                  isCenter: false,
                  inputType: TextInputType.number,
                  hasBorder: true,
                  hint: 'Check number'.tr,
                  label: 'Check number'.tr,
                  controller: chequeNoController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please enter all fields';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SelectableEntryField<BanksModel>(
                  enableOnTab: true,
                  selected: bankName,
                  items: banks ?? [],
                  textValue: (val) {
                    bankName = val.nameAr ?? '';

                    return val.nameAr!;
                  },
                  hint: 'Bank name'.tr,
                  label: 'Bank name'.tr,
                  valueColor:
                      Get.isDarkMode ? Colors.grey : Constants.textColor,
                  valueWeight: FontWeight.w500,
                  labelWeight: FontWeight.w500,
                  labelColor: Constants.textColor2,
                ),
                SizedBox(height: 8.h),
                EntryField(
                    hasTitle: true,
                    isCenter: false,
                    hasBorder: true,
                    hint: 'Drawer'.tr,
                    label: 'Drawer'.tr,
                    controller: chequePersonController),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const SizedBox(width: 6),
                    Expanded(
                        child: EntryField(
                            hasTitle: true,
                            isCenter: false,
                            hasBorder: true,
                            inputType: TextInputType.number,
                            hint: 'The value of the check'.tr,
                            label: 'The value of the check'.tr,
                            controller: chequeAmountController)),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: DateEntryField(
                        textEditingController: chequeDateController,
                        label: 'check date'.tr,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomButton(
                          onTap: () {
                            onTapEditCheque(index);
                          },
                          height: 45,
                          text: 'Modify'.tr,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomButton(
                          onTap: () {
                            setState(() {
                              chequeList.removeAt(index);
                              sum = 0;
                              chequeList.forEach((element) {
                                sum = sum + element.chequeAmount!;
                              });
                            });

                            Navigator.pop(context);
                          },
                          height: 45,
                          color: Colors.red,
                          text: 'Delete'.tr,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  onTapChequeListItem(int index) {
    chequePersonController.text =
        chequeList[index].chequePerson.toString() ?? '';
    chequeAmountController.text = chequeList[index].chequeAmount.toString();
    chequeNoController.text = chequeList[index].chequeNo ?? '';
    chequeDateController.text = chequeList[index].chequeDate ?? '';

    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              height: 600.h,
              child: editCheque(index, context)),
        );
      },
    );
  }

  addCheque(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    chequeNoController.clear();
                    chequeAmountController.clear();
                    chequePersonController.clear();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel,
                      color: Get.isDarkMode
                          ? Colors.blueGrey
                          : Constants.textColor2,
                      size: 30),
                ),
              ),
              Text(
                'Add check'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              EntryField(
                hasTitle: true,
                isCenter: false,
                hasBorder: true,
                inputType: TextInputType.number,
                hint: 'Check number'.tr,
                label: 'Check number'.tr,
                color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                controller: chequeNoController,
              ),
              const SizedBox(height: 10),
              SelectableEntryField<BanksModel>(
                enableOnTab: true,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                items: banks,
                textValue: (val) {
                  val.nameAr ?? '';
                  bankName = Get.locale!.languageCode == 'ar'
                      ? val.nameAr ?? ''
                      : val.nameEn ?? '';
                  return Get.locale!.languageCode == 'ar'
                      ? val.nameAr!
                      : val.nameEn!;
                },
                hint: 'Bank name'.tr,
                label: 'Bank name'.tr,
                labelColor:
                    Get.isDarkMode ? Colors.white : Constants.textColor2,
                valueColor:
                    Get.isDarkMode ? Colors.grey : Constants.primaryColor,
                valueWeight: FontWeight.w500,
                labelWeight: FontWeight.w500,
              ),
              SizedBox(height: 8.h),
              EntryField(
                color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                hasTitle: true,
                isCenter: false,
                hasBorder: true,
                hint: 'Drawer'.tr,
                label: 'Drawer'.tr,
                controller: chequePersonController,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  const SizedBox(width: 6),
                  Expanded(
                      child: EntryField(
                    color: Get.isDarkMode ? Colors.white : Constants.textColor2,
                    hasTitle: true,
                    isCenter: false,
                    inputType: TextInputType.number,
                    hasBorder: true,
                    hint: 'The value of the check'.tr,
                    label: 'The value of the check'.tr,
                    controller: chequeAmountController,
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: DateEntryField(
                      filled: Get.isDarkMode ? true : false,
                      color:
                          Get.isDarkMode ? Colors.white : Constants.textColor2,
                      textEditingController: chequeDateController,
                      label: 'check date'.tr,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: CustomButton(
                  onTap: () {
                    onTapAddCheque();
                  },
                  height: 45,
                  width: ScreenUtil().screenWidth - 50,
                  text: 'Add check'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapAddCheque() {
    if (chequeDateController.text.isNotEmpty &&
        chequePersonController.text.isNotEmpty &&
        chequeAmountController.text.isNotEmpty &&
        chequeNoController.text.isNotEmpty) {
      setState(() {
        chequeList.add(Cheques(
            chequeAmount: int.tryParse(chequeAmountController.text),
            chequeNo: chequeNoController.text.toString(),
            agentAccountNo: 80,
            bankAccountNo: 0,
            chequeDate: chequeDateController.text,
            chequePerson: chequePersonController.text,
            bankName: bankName));
      });

      sum = 0;

      chequeList.forEach((element) {
        setState(() {
          sum = sum + element.chequeAmount!;
        });
      });
      chequeNoController.clear();
      chequeAmountController.clear();
      chequePersonController.clear();
      Navigator.pop(context);
    } else {
      Get.snackbar('AlertOne'.tr, 'The fields is empty'.tr,
          backgroundColor: Colors.white, colorText: Constants.textColor2);
    }
  }

  onTapEditCheque(int index) {
    if (formKey.currentState!.validate()) {
      chequeList.removeAt(index);

      setState(() {
        chequeList.insert(
            index,
            Cheques(
                chequeAmount: int.tryParse(chequeAmountController.text),
                chequeNo: chequeNoController.text,
                chequeDate: chequeDateController.text,
                agentAccountNo: 2,
                chequePerson: chequePersonController.text,
                bankName: bankName));
        sum = 0;

        chequeList.forEach((element) {
          sum = sum + element.chequeAmount!;
        });
      });
    }
    chequeNoController.clear();
    chequeAmountController.clear();
    chequePersonController.clear();
    Navigator.pop(context);
  }

  Future<dynamic> buildDefaultDialog() {
    return Get.defaultDialog(
        title: 'Select Options'.tr,
        content: Column(
          children: [
            InkWell(
                child: Row(
                  children: const [
                    Icon(Icons.picture_as_pdf_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Pdf', style: TextStyle(fontSize: 18)),
                  ],
                ),
                onTap: () async {
                  getformattedTime(TimeOfDay time) {
                    return '${time.hour}:${time.minute} ${time.period.toString().split('.')[1]}';
                  }

                  TimeOfDay initialTime = TimeOfDay.now();

                  var date =
                      '${DateFormat("yyyy-MM-dd").format(DateTime.now())}  ${getformattedTime(initialTime)}';
                  final pdfFile = await PdfInvoice.generate(
                      customer: widget.customerIdModel!,
                      invoice: cashReceiptModel,
                      userModel: getUser()!,
                      date: date);
                  PdfApi.openFile(pdfFile);
                }),
            const Divider(
              thickness: 0.4,
            ),
            InkWell(
                onTap: () {
                  handlePrintAction();
                },
                child: Row(
                  children: [
                    const Icon(Icons.local_print_shop_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Printer'.tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ))
          ],
        ));
  }

  getData() {
    sum = widget.cashReciept!.cheque!.toDouble();
    accountName = widget.customerIdModel == null
        ? widget.customer!.accountName
        : widget.customerIdModel!.accountName;
    cash = TextEditingController(
        text: widget.cashReciept!.cash!.toStringAsFixed(3));
    statementController =
        TextEditingController(text: widget.cashReciept!.statement!);
    if (chequeList.isEmpty) {
      chequeList.addAll(widget.cashReciept!.cheques ?? []);
    }
  }
}
