import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/constants.dart';
import '../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/storage.dart';
import '../widgets/custom_button.dart';
import '../widgets/entry_field_widget.dart';
import '../../models/printer_method.dart';
import '../widgets/selectable_entry_field.dart';

class PrinterSettingsScreen extends StatefulWidget {
  const PrinterSettingsScreen({Key? key}) : super(key: key);

  @override
  _PrinterSettingsScreenState createState() => _PrinterSettingsScreenState();
}

class _PrinterSettingsScreenState extends State<PrinterSettingsScreen> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? printerType;
  var customersController = CustomerCubit();

  TextEditingController macAddressController = TextEditingController();
  TextEditingController printertypeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var macAddress = GetStorage().read('Mac Address');
    if (macAddress != null) {
      macAddressController.text = macAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Printer settings'.tr,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Constants.textColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Color(0xffA1C1E0),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        child: EntryField(
                          controller: macAddressController
                            ..text = getUser()!
                                .userCompanies!
                                .first
                                .printerMacAddress!,
                          labelFontWeight: FontWeight.bold,
                          filled: true,
                          hasTitle: true,
                          hint: 'Mac Address'.tr,
                          label: 'Mac Address'.tr,
                          isCenter: false,
                          hasBorder: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SelectableEntryField<PrinterMethod>(
                        controller: printertypeController,
                        labelWeight: FontWeight.w700,
                        onSelect: (val) {
                          setState(() {});
                          printerType = val.nameEN;
                        },
                        enableOnTab: true,
                        items: Constants.printerMethod,
                        selected: GetStorage().read('Printer type') ?? null,
                        labelColor: Get.isDarkMode
                            ? Colors.white
                            : Constants.textColor2,
                        textValue: (val) => val.nameEN.toString() ?? '',
                        hasTitle: true,
                        hint: 'Printer type'.tr,
                        label: 'Printer type'.tr,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: CustomButton(
                            onTap: () {
                              GetStorage().write('Printer type', printerType);
                              GetStorage().write(
                                  'Mac Address', macAddressController.text);
                              Get.defaultDialog(
                                  title: '',
                                  titlePadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Constants.primaryColor,
                                        size: 30,
                                      ),
                                      Text(
                                        'Saved successfully'.tr,
                                        style: const TextStyle(
                                            color: Constants.textColor2),
                                      ),
                                    ],
                                  ));
                            },
                            color: Constants.primaryColor,
                            text: 'Confirmation'.tr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ]))),
    );
  }
}
