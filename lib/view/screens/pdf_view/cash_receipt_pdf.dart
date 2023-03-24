import 'dart:io';
import 'package:firstprojects/controllers/pdf_services/pdf_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../../models/Customers/customer_id_model.dart';
import '../../../models/cash receipt model/cash_receipt_model.dart';
import '../../../models/user/user.dart';

class PdfInvoice {
  static Future<File> generate(
      {CustomerIdModel? customer,
      CashReceiptModel? invoice,
      UserModel? userModel,
      String? date}) async {
    final imageByteData =
        await rootBundle.load('assets/images/unnamed.png');
    // Convert ByteData to Uint8List
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    final image = pw.MemoryImage(imageUint8List);
    final pdf = Document();
    var arabicFont = Font.ttf(
        await rootBundle.load("assets/fonts/IBMPlexSansArabic-Medium.ttf"));

    pdf.addPage(Page(
        pageTheme: PageTheme(
          margin: const EdgeInsets.all(20),
          theme: ThemeData.withFont(
            base: arabicFont,
          ),
        ),
        build: (context) =>
            buildBdf(image, userModel, invoice, customer, date)));

    return PdfApi.saveDocument(
        name: '${customer == null ? 'hassan' : customer.accountName}.pdf',
        pdf: pdf);
  }

  static pw.Column buildBdf(pw.MemoryImage image, UserModel? userModel,
      CashReceiptModel? invoice, CustomerIdModel? customer, String? date) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(image, height: 80),
              buildInvoiceInfo2(userModel!),
            ],
          ),
          SizedBox(height: 7),
          Row(
              mainAxisAlignment: Get.locale!.languageCode == 'ar'
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text('Cash Receipt'.tr,
                        style: const TextStyle(
                            fontSize: 25, color: PdfColors.blue700))),
              ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            buildInvoiceInfo(userModel, invoice!, customer!, date!),
          ]),
          SizedBox(height: 30),
          buildInvoice(invoice),
          invoice.cheques!.length > 14
              ? buildInvoiceN1(invoice)
              : SizedBox(),
          invoice.cheques!.length > 46
              ? buildInvoiceN2(invoice)
              : SizedBox(),
          invoice.cheques!.length > 78
              ? buildInvoiceN3(invoice)
              : SizedBox(),
          invoice.cheques!.length > 110
              ? buildInvoiceN4(invoice)
              : SizedBox(),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Get.locale!.languageCode == 'ar'
                  ? buildTextAr(
                      title: 'Signature:'.tr,
                    )
                  : buildTextEn(
                      title: 'Signature:'.tr,
                    ),
            ),
            Expanded(
              child: Get.locale!.languageCode == 'ar'
                  ? buildTextAr(
                      title: 'Resident Name:'.tr,
                    )
                  : buildTextEn(
                      title: 'Resident Name:'.tr,
                    ),
            )
          ])
        ]);
  }

  static Widget buildInvoiceInfo2(UserModel info) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Directionality(
          textDirection: TextDirection.rtl,
          child: Text(info.userCompanies!.first.company!.companyName!,
              style: const TextStyle(
                fontSize: 22,
              ))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Text(info.userCompanies!.first.company!.companyAddress!,
              style: TextStyle(fontSize: 10))),
      Row(children: [
        Text(
            '${info.userCompanies!.first.company!.phoneNumber!}-${info.userCompanies!.first.company!.mobileNumber!}',
            style: TextStyle(fontSize: 10)),
      ]),
      Row(children: [
        Text(info.userCompanies!.first.company!.email!,
            style: TextStyle(fontSize: 10)),
      ]),
      Row(children: [
        Text('Tax No: ' '${info.userCompanies!.first.company!.taxNumber!}',
            style: const TextStyle(fontSize: 10)),
      ]),
    ]);
  }

  static Widget buildCustomerAddress(UserModel userModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userModel.fullName!,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(userModel.email!),
        ],
      );

  static Widget buildInvoiceInfo(UserModel info, CashReceiptModel invoice,
      CustomerIdModel customer, String date) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 30),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Text('Bill to'.tr, style: const TextStyle(fontSize: 13))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Text(customer.accountName.toString(),
              style: const TextStyle(fontSize: 10))),
      Text(customer.accountNo.toString(),
          style: const TextStyle(
            fontSize: 10,
          )),
      Text(customer.accountInfo!.address.toString(),
          style: const TextStyle(fontSize: 10),
          textDirection: TextDirection.rtl),
      Text(customer.accountInfo!.taxNo!,
          style: const TextStyle(
            fontSize: 10,
          )),
      SizedBox(height: 14),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: Get.locale!.languageCode == 'ar'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('Customer Info'.tr,
                          style: const TextStyle(fontSize: 13))),
                  buildInvoice5(info, invoice, date, customer)
                ]),
            SizedBox(width: 50),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: Get.locale!.languageCode == 'ar'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  SizedBox(
                    width: 250,
                  ),
                  SizedBox(height: 2),
                  SizedBox(height: 1),
                  buildInvoice2(info, invoice)
                ])
          ])
    ]);
  }

  static Widget buildInvoice5(
      UserModel info, CashReceiptModel invoice, String date, customer) {
    final titles = <String>[
      'Account Name'.tr,
      'Account No'.tr,
      'Tax No'.tr,
      'Payment For'.tr,
      'Date'.tr
    ];

    final data = <String>[
      customer.accountName!,
      customer.accountNo.toString(),
      customer.accountInfo!.taxNo.toString(),
      invoice.statement.toString(),
      date,
    ];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(titles.length, (index) {
            final title = titles[index];
            final value = data[index];

            return Get.locale!.languageCode == 'ar'
                ? buildTextAr(title: title, value: value, width: 230)
                : buildTextEn(title: title, value: value, width: 230);
          }),
        ]);
  }

  static Widget buildInvoice2(UserModel info, CashReceiptModel invoice) {
    final titles = <String>[
      'Transaction No'.tr,
      'Date'.tr,
      'Salesman'.tr,
      'Cash'.tr,
      'Cheque'.tr,
      'Total'.tr,
    ];
    var total = invoice.cheque! + invoice.cash!;
    final data = <String>[
      invoice.bondNo.toString(),
      invoice.bondDate.toString(),
      invoice.salesman!.name.toString(),
      invoice.cash!.toStringAsFixed(3),
      invoice.cheque!.toStringAsFixed(3),
      total.toStringAsFixed(3)
    ];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(titles.length, (index) {
            final title = titles[index];
            final value = data[index];
            return Get.locale!.languageCode == 'ar'
                ? buildTextAr(title: title, value: value, width: 230)
                : buildTextEn(title: title, value: value, width: 230);
          }),
        ]);
  }

  static Widget buildInvoice(CashReceiptModel invoice) {
    final headers = [
      'Cheque No'.tr,
      'Bank'.tr,
      'Cheque Date'.tr,
      'Cheque Person'.tr,
      'Amount'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 0;    i <
          (invoice.cheques!.length > 14
              ? 14
              : invoice.cheques!.length); i++)
        {
          'cheque No': "${invoice.cheques![i].chequeNo}",
          'bank Name': "${invoice.cheques![i].bankName}",
          'cheque Date': "${invoice.cheques![i].chequeDate}",
          'cheque Person': "${invoice.cheques![i].chequePerson}",
          'cheque Amount': invoice.cheques![i].chequeAmount!.toStringAsFixed(3),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return invoice.cheques!.isNotEmpty
        ? Directionality(
            textDirection: pw.TextDirection.rtl,
            child: Table.fromTextArray(
              headers: headers,
              data: listOfPurchases,
              border: const TableBorder(
                  bottom: BorderSide(width: 0.5, color: PdfColors.black)),
              cellStyle: const TextStyle(fontSize: 10),
              tableWidth: TableWidth.max,
              headerStyle: const TextStyle(
                fontSize: 10,
                color: PdfColors.white,
              ),
              oddRowDecoration: const BoxDecoration(
                  border: pw.Border(
                top: BorderSide(width: 0, color: PdfColors.black),
              )),
              headerDecoration: const BoxDecoration(
                  color: PdfColors.blue700,
                  border: pw.Border(
                      top: BorderSide(width: 0.5, color: PdfColors.blue),
                      bottom: BorderSide(width: 0.5, color: PdfColors.blue))),
              cellHeight: 30,
              cellAlignments: {
                0: Alignment.center,
                1: Alignment.center,
                2: Alignment.center,
                3: Alignment.center,
                4: Alignment.center,
                5: Alignment.center,
              },
            ))
        : Center(
            child: Text('لا يوجد مواد',
                style: const TextStyle(fontSize: 25, color: PdfColors.blue),
                textDirection: TextDirection.rtl));
  }
  static Widget buildInvoiceN1(CashReceiptModel invoice) {
    final headers = [
      'Cheque No'.tr,
      'Bank'.tr,
      'Cheque Date'.tr,
      'Cheque Person'.tr,
      'Amount'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 14;
      i <
          (invoice.cheques!.length > 46
              ? 46
              : invoice.cheques!.length);
      i++)
        {
          'cheque No': "${invoice.cheques![i].chequeNo}",
          'bank Name': "${invoice.cheques![i].bankName}",
          'cheque Date': "${invoice.cheques![i].chequeDate}",
          'cheque Person': "${invoice.cheques![i].chequePerson}",
          'cheque Amount': invoice.cheques![i].chequeAmount!.toStringAsFixed(3),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return Directionality(
        textDirection: pw.TextDirection.rtl,
        child: Table.fromTextArray(
          data: listOfPurchases,
          border: const TableBorder(
              bottom: BorderSide(width: 0.5, color: PdfColors.black)),
          cellStyle: const TextStyle(fontSize: 10),
          tableWidth: TableWidth.max,
          headerStyle: const TextStyle(
            fontSize: 10,
            color: PdfColors.white,
          ),
          rowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          oddRowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          cellHeight: 20,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
            4: Alignment.center,
            5: Alignment.center,

          },
        ));
  }
  static Widget buildInvoiceN2(CashReceiptModel invoice) {
    final headers = [
      'Cheque No'.tr,
      'Bank'.tr,
      'Cheque Date'.tr,
      'Cheque Person'.tr,
      'Amount'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 46;
      i <
          (invoice.cheques!.length > 78
              ? 78
              : invoice.cheques!.length);
      i++)
        {
          'cheque No': "${invoice.cheques![i].chequeNo}",
          'bank Name': "${invoice.cheques![i].bankName}",
          'cheque Date': "${invoice.cheques![i].chequeDate}",
          'cheque Person': "${invoice.cheques![i].chequePerson}",
          'cheque Amount': invoice.cheques![i].chequeAmount!.toStringAsFixed(3),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return Directionality(
        textDirection: pw.TextDirection.rtl,
        child: Table.fromTextArray(
          data: listOfPurchases,
          border: const TableBorder(
              bottom: BorderSide(width: 0.5, color: PdfColors.black)),
          cellStyle: const TextStyle(fontSize: 10),
          tableWidth: TableWidth.max,
          headerStyle: const TextStyle(
            fontSize: 10,
            color: PdfColors.white,
          ),
          rowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          oddRowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          cellHeight: 20,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
            4: Alignment.center,
            5: Alignment.center,

          },
        ));
  }
  static Widget buildInvoiceN3(CashReceiptModel invoice) {
    final headers = [
      'Cheque No'.tr,
      'Bank'.tr,
      'Cheque Date'.tr,
      'Cheque Person'.tr,
      'Amount'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 78;
      i <
          (invoice.cheques!.length > 110
              ? 110
              : invoice.cheques!.length);
      i++)
        {
          'cheque No': "${invoice.cheques![i].chequeNo}",
          'bank Name': "${invoice.cheques![i].bankName}",
          'cheque Date': "${invoice.cheques![i].chequeDate}",
          'cheque Person': "${invoice.cheques![i].chequePerson}",
          'cheque Amount': invoice.cheques![i].chequeAmount!.toStringAsFixed(3),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return Directionality(
        textDirection: pw.TextDirection.rtl,
        child: Table.fromTextArray(
          data: listOfPurchases,
          border: const TableBorder(
              bottom: BorderSide(width: 0.5, color: PdfColors.black)),
          cellStyle: const TextStyle(fontSize: 10),
          tableWidth: TableWidth.max,
          headerStyle: const TextStyle(
            fontSize: 10,
            color: PdfColors.white,
          ),
          rowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          oddRowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          cellHeight: 20,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
            4: Alignment.center,
            5: Alignment.center,

          },
        ));
  }
  static Widget buildInvoiceN4(CashReceiptModel invoice) {
    final headers = [
      'Cheque No'.tr,
      'Bank'.tr,
      'Cheque Date'.tr,
      'Cheque Person'.tr,
      'Amount'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 110; i < invoice.cheques!.length; i++)
        {
          'cheque No': "${invoice.cheques![i].chequeNo}",
          'bank Name': "${invoice.cheques![i].bankName}",
          'cheque Date': "${invoice.cheques![i].chequeDate}",
          'cheque Person': "${invoice.cheques![i].chequePerson}",
          'cheque Amount': invoice.cheques![i].chequeAmount!.toStringAsFixed(3),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return Directionality(
        textDirection: pw.TextDirection.rtl,
        child: Table.fromTextArray(
          data: listOfPurchases,
          border: const TableBorder(
              bottom: BorderSide(width: 0.5, color: PdfColors.black)),
          cellStyle: const TextStyle(fontSize: 10),
          tableWidth: TableWidth.max,
          headerStyle: const TextStyle(
            fontSize: 10,
            color: PdfColors.white,
          ),
          rowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          oddRowDecoration: const BoxDecoration(
              border: pw.Border(
                bottom: BorderSide(width: 1, color: PdfColors.black),
              )),
          cellHeight: 20,
          cellAlignments: {
            0: Alignment.center,
            1: Alignment.center,
            2: Alignment.center,
            3: Alignment.center,
            4: Alignment.center,
            5: Alignment.center,

          },
        ));
  }


  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildTextEn({
    required String title,
    String? value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle;

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 10))),
          value == null
              ? SizedBox()
              : Text(value,
                  style: unite ? style : const TextStyle(fontSize: 10),
                  textDirection: TextDirection.rtl),
        ],
      ),
    );
  }

  static buildTextAr({
    required String title,
    String? value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle;

    return Container(
      width: width,
      child: Row(
        children: [
          value == null
              ? SizedBox()
              : Text(value,
                  style: unite ? style : const TextStyle(fontSize: 12),
                  textDirection: TextDirection.rtl),
          Spacer(flex: 2),
          Text(title,
              style: const TextStyle(fontSize: 12),
              textDirection: TextDirection.rtl),
        ],
      ),
    );
  }
}

