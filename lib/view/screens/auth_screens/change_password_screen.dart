import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_field_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassController = TextEditingController();

  TextEditingController newPassController = TextEditingController();

  TextEditingController confirmNewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Change password'.tr,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
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
                  color: Get.isDarkMode ? DARK_GREY2 : Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EntryField(
                    controller: oldPassController,
                    hasBorder: true,
                    isCenter: false,
                    isSecure: true,
                    onChanged: (c) {
                      setState(() {});
                    },
                    hasTitle: true,
                    hint: 'old password'.tr,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  EntryField(
                    onChanged: (c) {
                      setState(() {});
                    },
                    controller: newPassController,
                    hasBorder: true,
                    isSecure: true,
                    isCenter: false,
                    hasTitle: true,
                    hint: 'New password'.tr,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  EntryField(
                    onChanged: (c) {
                      setState(() {});
                    },
                    controller: confirmNewPassController,
                    hasBorder: true,
                    isCenter: false,
                    isSecure: true,
                    hasTitle: true,
                    hint: 'confirm password'.tr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (oldPassController.text.isEmpty ||
                          newPassController.text.isEmpty ||
                          confirmNewPassController.text.isEmpty)
                      ? const SizedBox()
                      : const SizedBox(),
                  (newPassController.text != confirmNewPassController.text)
                      ? SizedBox(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.info,
                                  color: Colors.red,
                                ),
                                Text("يجب توافق كلمه السر")
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      onTap: () {
                        if ((oldPassController.text.isEmpty ||
                                newPassController.text.isEmpty ||
                                confirmNewPassController.text.isEmpty) ||
                            (newPassController.text !=
                                confirmNewPassController.text)) {
                          Get.snackbar("validate", "please validate fields",
                              backgroundColor: Colors.white,
                              colorText: Constants.primaryColor);
                        } else {
                          AuthCubit().changePass(
                              oldPassController.text, newPassController.text);
                        }
                      },
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
}
