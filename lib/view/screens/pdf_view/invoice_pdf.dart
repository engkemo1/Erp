import 'dart:io';
import 'package:firstprojects/controllers/pdf_services/pdf_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../models/Customers/customer_id_model.dart';
import '../../../models/invoices_model/get_invoice_id_model/get_invoice_id.dart';
import '../../../models/user/user.dart';

class PdfInvoice {
  static Future<File> generate(
      {CustomerIdModel? customer,
      GetInvoiceIdModel? invoice,
      UserModel? userModel,
      String? date}) async {
    final imageByteData = await rootBundle.load('assets/images/unnamed.png');
    // Convert ByteData to Uint8List
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    final image = pw.MemoryImage(imageUint8List);
    final pdf = Document();
    var arabicFont = Font.ttf(
        await rootBundle.load("assets/fonts/IBMPlexSansArabic-Medium.ttf"));

    pdf.addPage(MultiPage(
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          clip: true,
          theme: ThemeData.withFont(
            base: arabicFont,
          ),
        ),
        build: (context) =>
            [buildBdf(image, userModel, invoice, customer, date)]));

    return PdfApi.saveDocument(
        name: '${customer == null ? 'hassan' : customer.accountName}.pdf',
        pdf: pdf);
  }

  static pw.Column buildBdf(pw.MemoryImage image, UserModel? userModel,
      GetInvoiceIdModel? invoice, CustomerIdModel? customer, String? date) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
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
                    child: Text('Invoice'.tr,
                        style: const TextStyle(
                            fontSize: 25, color: PdfColors.blue700))),
              ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            buildInvoiceInfo(userModel, invoice!, customer!, date!),
          ]),
          SizedBox(height: 30),
          buildInvoice(invoice),
          invoice.inventoryTransactionItems!.length > 14
              ? buildInvoiceN1(invoice)
              : SizedBox(),
          invoice.inventoryTransactionItems!.length > 46
              ? buildInvoiceN2(invoice)
              : SizedBox(),
          invoice.inventoryTransactionItems!.length > 78
              ? buildInvoiceN3(invoice)
              : SizedBox(),
          invoice.inventoryTransactionItems!.length > 110
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

  static Widget buildInvoiceInfo(UserModel info, GetInvoiceIdModel invoice,
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
                      child: Text('Details'.tr,
                          style: const TextStyle(fontSize: 13))),
                  buildInvoice5(info, invoice, date)
                ]),
            SizedBox(width: 50),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: Get.locale!.languageCode == 'ar'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('Summary'.tr,
                          style: const TextStyle(fontSize: 12))),
                  SizedBox(
                    width: 250,
                    child: Divider(color: PdfColors.grey, thickness: 2),
                  ),
                  SizedBox(height: 3),
                  buildInvoice3(info, invoice),
                  SizedBox(
                    width: 250,
                    child: Divider(color: PdfColors.grey, thickness: 1),
                  ),
                  SizedBox(height: 2),
                  SizedBox(height: 1),
                  buildInvoice2(info, invoice)
                ])
          ])
    ]);
  }

//Creates a digital signature and sets signature information

  static Widget buildInvoice5(
      UserModel info, GetInvoiceIdModel invoice, String date) {
    final titles = <String>[
      'Invoice number'.tr,
      'Invoice date'.tr,
      'Salesman'.tr,
      'Payment Type'.tr,
      'Date'.tr
    ];

    final data = <String>[
      invoice.transactionNo.toString(),
      invoice.transactionDate.toString(),
      invoice.salesmen==null?'': invoice.salesmen!.name.toString(),
      invoice.payType==null?'':invoice.payType!.nameAr!.toString(),
      date
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

  static Widget buildInvoice2(UserModel info, GetInvoiceIdModel invoice) {
    final titles = <String>[
      'Subtotal in JOD'.tr,
      'VAT'.tr,
      'Total in JOD'.tr,
    ];

    final data = <String>[
      invoice.totalBeforeTax==null?'0':  invoice.totalBeforeTax.toStringAsFixed(0),
      invoice.discount.toString()??'0',
      invoice.totalAfterTax.toString()
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

  static Widget buildInvoice3(UserModel info, GetInvoiceIdModel invoice) {
    final titles = <String>[
      'Total in JOD'.tr,
    ];

    final data = <String>[
      invoice.totalAfterTax.toString(),
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

  static Widget buildInvoice(GetInvoiceIdModel invoice) {
    final headers = [
      'Item No'.tr,
      'Item Name'.tr,
      'Unit'.tr,
      'QTY'.tr,
      'Price'.tr,
      'Discount'.tr,
      'Tax'.tr,
      'Total'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 0;
          i <
              (invoice.inventoryTransactionItems!.length > 14
                  ? 14
                  : invoice.inventoryTransactionItems!.length);
          i++)
        {
          "Item No": invoice.transactionNo.toString(),
          "Item Name": invoice.inventoryTransactionItems![i].itemName ?? '',
          "Unit": invoice.inventoryTransactionItems![i].itemUnit == null
              ? ''
              : invoice.inventoryTransactionItems![i].itemUnit!.nameAr ?? '',
          "QTY": invoice.inventoryTransactionItems![i].quantity.toString(),
          "Price":
              invoice.inventoryTransactionItems![i].price!.toStringAsFixed(0),
          "Discount":
              invoice.inventoryTransactionItems![i].taxPercentage.toString(),
          "Tax":
              invoice.inventoryTransactionItems![i].discountAmount.toString(),
          "Total":
              invoice.inventoryTransactionItems![i].totalAfterTax.toString(),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return invoice.inventoryTransactionItems!.isNotEmpty
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
              rowDecoration: const BoxDecoration(
                  border: pw.Border(
                top: BorderSide(width: 1, color: PdfColors.black),
              )),
              headerDecoration: const BoxDecoration(
                  color: PdfColors.blue700,
                  border: pw.Border(
                      top: BorderSide(width: 0.5, color: PdfColors.blue),
                      bottom: BorderSide(width: 0.5, color: PdfColors.blue))),
              cellHeight: 20,
              cellAlignments: {
                0: Alignment.center,
                1: Alignment.center,
                2: Alignment.center,
                3: Alignment.center,
                4: Alignment.center,
                5: Alignment.center,
                6: Alignment.center,
                7: Alignment.center,
              },
            ))
        : Center(
            child: Text('لا يوجد مواد',
                style: const TextStyle(fontSize: 25, color: PdfColors.blue),
                textDirection: TextDirection.rtl));
  }

  static Widget buildInvoiceN1(GetInvoiceIdModel invoice) {
    final headers = [
      'Item No'.tr,
      'Item Name'.tr,
      'Unit'.tr,
      'QTY'.tr,
      'Price'.tr,
      'Discount'.tr,
      'Tax'.tr,
      'Total'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 14;
          i <
              (invoice.inventoryTransactionItems!.length > 46
                  ? 46
                  : invoice.inventoryTransactionItems!.length);
          i++)
        {
          "Item No": invoice.transactionNo.toString(),
          "Item Name": invoice.inventoryTransactionItems![i].itemName ?? '',
          "Unit": invoice.inventoryTransactionItems![i].itemUnit == null
              ? ''
              : invoice.inventoryTransactionItems![i].itemUnit!.nameAr ?? '',
          "QTY": invoice.inventoryTransactionItems![i].quantity.toString(),
          "Price":
              invoice.inventoryTransactionItems![i].price!.toStringAsFixed(0),
          "Discount":
              invoice.inventoryTransactionItems![i].taxPercentage.toString(),
          "Tax":
              invoice.inventoryTransactionItems![i].discountAmount.toString(),
          "Total":
              invoice.inventoryTransactionItems![i].totalAfterTax.toString(),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return invoice.inventoryTransactionItems!.isNotEmpty
        ? Directionality(
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
                6: Alignment.center,
                7: Alignment.center,
              },
            ))
        : Center(
            child: Text('لا يوجد مواد',
                style: const TextStyle(fontSize: 25, color: PdfColors.blue),
                textDirection: TextDirection.rtl));
  }

  static Widget buildInvoiceN2(GetInvoiceIdModel invoice) {
    final headers = [
      'Item No'.tr,
      'Item Name'.tr,
      'Unit'.tr,
      'QTY'.tr,
      'Price'.tr,
      'Discount'.tr,
      'Tax'.tr,
      'Total'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 46;
          i <
              (invoice.inventoryTransactionItems!.length > 78
                  ? 78
                  : invoice.inventoryTransactionItems!.length);
          i++)
        {
          "Item No": invoice.transactionNo.toString(),
          "Item Name": invoice.inventoryTransactionItems![i].itemName ?? '',
          "Unit": invoice.inventoryTransactionItems![i].itemUnit == null
              ? ''
              : invoice.inventoryTransactionItems![i].itemUnit!.nameAr ?? '',
          "QTY": invoice.inventoryTransactionItems![i].quantity.toString(),
          "Price":
              invoice.inventoryTransactionItems![i].price!.toStringAsFixed(0),
          "Discount":
              invoice.inventoryTransactionItems![i].taxPercentage.toString(),
          "Tax":
              invoice.inventoryTransactionItems![i].discountAmount.toString(),
          "Total":
              invoice.inventoryTransactionItems![i].totalAfterTax.toString(),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return invoice.inventoryTransactionItems!.isNotEmpty
        ? Directionality(
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
                6: Alignment.center,
                7: Alignment.center,
              },
            ))
        : Center(
            child: Text('لا يوجد مواد',
                style: const TextStyle(fontSize: 25, color: PdfColors.blue),
                textDirection: TextDirection.rtl));
  }

  static Widget buildInvoiceN3(GetInvoiceIdModel invoice) {
    final headers = [
      'Item No'.tr,
      'Item Name'.tr,
      'Unit'.tr,
      'QTY'.tr,
      'Price'.tr,
      'Discount'.tr,
      'Tax'.tr,
      'Total'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 78;
          i <
              (invoice.inventoryTransactionItems!.length > 110
                  ? 110
                  : invoice.inventoryTransactionItems!.length);
          i++)
        {
          "Item No": invoice.transactionNo.toString(),
          "Item Name": invoice.inventoryTransactionItems![i].itemName ?? '',
          "Unit": invoice.inventoryTransactionItems![i].itemUnit == null
              ? ''
              : invoice.inventoryTransactionItems![i].itemUnit!.nameAr ?? '',
          "QTY": invoice.inventoryTransactionItems![i].quantity.toString(),
          "Price":
              invoice.inventoryTransactionItems![i].price!.toStringAsFixed(0),
          "Discount":
              invoice.inventoryTransactionItems![i].taxPercentage.toString(),
          "Tax":
              invoice.inventoryTransactionItems![i].discountAmount.toString(),
          "Total":
              invoice.inventoryTransactionItems![i].totalAfterTax.toString(),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return invoice.inventoryTransactionItems!.isNotEmpty
        ? Directionality(
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
                6: Alignment.center,
                7: Alignment.center,
              },
            ))
        : Center(
            child: Text('لا يوجد مواد',
                style: const TextStyle(fontSize: 25, color: PdfColors.blue),
                textDirection: TextDirection.rtl));
  }

  static Widget buildInvoiceN4(GetInvoiceIdModel invoice) {
    final headers = [
      'Item No'.tr,
      'Item Name'.tr,
      'Unit'.tr,
      'QTY'.tr,
      'Price'.tr,
      'Discount'.tr,
      'Tax'.tr,
      'Total'.tr,
    ];
    var purchasesAsMap = <Map<String, String>>[
      for (int i = 110; i < invoice.inventoryTransactionItems!.length; i++)
        {
          "Item No": invoice.transactionNo.toString(),
          "Item Name": invoice.inventoryTransactionItems![i].itemName ?? '',
          "Unit": invoice.inventoryTransactionItems![i].itemUnit == null
              ? ''
              : invoice.inventoryTransactionItems![i].itemUnit!.nameAr ?? '',
          "QTY": invoice.inventoryTransactionItems![i].quantity.toString(),
          "Price":
              invoice.inventoryTransactionItems![i].price!.toStringAsFixed(0),
          "Discount":
              invoice.inventoryTransactionItems![i].taxPercentage.toString(),
          "Tax":
              invoice.inventoryTransactionItems![i].discountAmount.toString(),
          "Total":
              invoice.inventoryTransactionItems![i].totalAfterTax.toString(),
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < purchasesAsMap.length; i++) {
      listOfPurchases.add(purchasesAsMap[i].values.toList());
    }

    return invoice.inventoryTransactionItems!.isNotEmpty
        ? Directionality(
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
                6: Alignment.center,
                7: Alignment.center,
              },
            ))
        : Center(
            child: Text('لا يوجد مواد',
                style: const TextStyle(fontSize: 25, color: PdfColors.blue),
                textDirection: TextDirection.rtl));
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
