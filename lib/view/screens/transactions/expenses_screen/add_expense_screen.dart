import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firstprojects/controllers/cubit/expenses_cubit/expenses_cubit.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../models/transactions_models/expenses_model/expenses_model.dart';
import '../../../../utils/storage.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/date_entry_field.dart';
import '../../../widgets/entry_field_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  AddExpenseScreen({Key? key, this.id, this.expensesModel}) : super(key: key);
  ExpensesModel? expensesModel;
  int? id;

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id == 1 || widget.id != null) {
      print(widget.expensesModel!.id);
      setData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Expense Info'.tr,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Constants.textColor,
              fontSize: 21,
              fontWeight: FontWeight.bold),
        ),
        actions: widget.id != null
            ? [
                IconButton(
                    onPressed: () {
                      ExpensesCubit().delete(widget.expensesModel!.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ]
            : null,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? DARK_GREY3 : Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EntryField(
                    padding: const EdgeInsets.only(right: 10),
                    controller: _nameController,
                    hasBorder: Get.isDarkMode ? false : true,
                    filled: false,
                    isCenter: false,
                    labelFontWeight: FontWeight.w500,
                    hasTitle: true,
                    hint: 'Expense Name'.tr,
                    label: 'Expense Name *'.tr,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DateEntryField(
                    fontWeight: FontWeight.w500,
                    filled: true,
                    label: 'Date *'.tr,
                    textEditingController: _dateController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  EntryField(
                    labelFontWeight: FontWeight.w500,
                    filled: false,
                    controller: _valueController,
                    inputType: TextInputType.number,
                    padding: const EdgeInsets.only(right: 10),
                    hasBorder: Get.isDarkMode ? false : true,
                    isCenter: false,
                    hasTitle: true,
                    hint: 'Expense Value'.tr,
                    label: 'Expense Value *'.tr,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  EntryField(
                    labelFontWeight: FontWeight.w500,
                    padding: const EdgeInsets.only(right: 10),
                    filled: false,
                    isCenter: false,
                    hasBorder: Get.isDarkMode ? false : true,
                    controller: _noteController,
                    hasTitle: true,
                    hint: 'Notes'.tr,
                    label: 'Notes'.tr,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildFile(context),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      onTap: () {
                        if (_nameController.text.isNotEmpty &&
                            _valueController.text.isNotEmpty &&
                            _dateController.text.isNotEmpty) {
                          ExpensesModel expensesModel = ExpensesModel();
                          expensesModel.date = _dateController.text;
                          expensesModel.amount =
                              int.tryParse(_valueController.text);
                          expensesModel.notes = _noteController.text;
                          expensesModel.expensesName = _nameController.text;
                          expensesModel.documentUrl =
                              widget.expensesModel != null
                                  ? widget.expensesModel!.documentUrl
                                  : file!.path.split('/').last;
                          expensesModel.salesmanId =
                              getUser()!.userCompanies!.first.salesmanId;
                          expensesModel.id = widget.expensesModel != null
                              ? widget.expensesModel!.id
                              : 0;
                          expensesModel.batchId = widget.expensesModel != null
                              ? widget.expensesModel!.batchId
                              : -1;
                          expensesModel.source = widget.expensesModel != null
                              ? widget.expensesModel!.source
                              : 'mobile';

                          // file!.path.split('/').last

                          setState(() {});
                          if (widget.id == null) {
                            ExpensesCubit().create(expensesModel, context);
                          } else {
                            ExpensesCubit().update(expensesModel, context);
                          }
                        } else {
                          Get.snackbar('Portfolio Financial System'.tr,
                              'Please enter the required fields'.tr,
                              backgroundColor: Colors.white);
                        }
                      },
                      height: 45.h,
                      text: 'Confirmation'.tr,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildFile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'attachments'.tr,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: .1),
                  color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          file = null;
                        });
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey,
                      )),
                  Expanded(
                    child: Center(
                      child: Text(
                        file == null
                            ? 'attached'.tr
                            : file!.path.split('/').last,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            file = File(result.files.single.path!);
                          });
                        } else {
                          setState(() {});
                          // User canceled the picker
                        }
                      },
                      icon: const Icon(
                        Icons.attachment,
                        color: Colors.grey,
                      )),
                ],
              ))
        ],
      ),
    );
  }

  setData() {
    _dateController.text = widget.expensesModel!.date.toString();
    _noteController.text = widget.expensesModel!.notes.toString();
    _valueController.text = widget.expensesModel!.amount.toString();
    _nameController.text = widget.expensesModel!.expensesName.toString();
  }
}
