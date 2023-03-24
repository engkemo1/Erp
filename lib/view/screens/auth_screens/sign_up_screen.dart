import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../bottom_navigation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerCompany = TextEditingController();

  bool isNotValidate = false;
  String validationText = '';

  @override
  void initState() {
    super.initState();
  }

  void validate() {
    validationText = '';
    formKey.currentState!.validate();

    if (isNotValidate) {
      return;
    }
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Constants.primaryColor,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              color: Constants.primaryColor,
              child: Image.network(
                'https://wallpaperaccess.com/full/807588.jpg',
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  color: Colors.transparent,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Get.isDarkMode ? DARK_GREY3 : Colors.grey[200],
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Request an account'.tr,
                          style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Welcome to join our community'.tr,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        EntryField(
                          controller: _controllerName,
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          hasTitle: false,
                          hint: 'full name'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        EntryField(
                          inputType: TextInputType.emailAddress,
                          controller: _controllerEmail,
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hint: 'E-mail'.tr,
                          hasTitle: false,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        EntryField(
                          hintStyle: const TextStyle(color: Colors.grey),
                          inputType: TextInputType.phone,
                          controller: _controllerPhone,
                          prefixIcon: const Icon(
                            Icons.phone_android_outlined,
                            color: Colors.grey,
                          ),
                          hint: 'Telephone number'.tr,
                          hasTitle: false,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        EntryField(
                          controller: _controllerCompany,
                          hintStyle: const TextStyle(color: Colors.grey),
                          hasTitle: false,
                          prefixIcon: const Icon(
                            Icons.account_balance,
                            color: Colors.grey,
                          ),
                          hint: 'The Company name'.tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              validationText = 'One of the fields is empty'.tr;
                              setState(() {
                                isNotValidate = true;
                              });
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        CustomButton(
                          height: 47.h,
                          width: 280.w,
                          text: 'Registration'.tr,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: isNotValidate,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  validationText,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'I already have an account'.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        children: [
                          TextSpan(
                            text: 'Enter'.tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).pop(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
