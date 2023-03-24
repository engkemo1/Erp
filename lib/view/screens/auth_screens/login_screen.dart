import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:firstprojects/models/user/user.dart';
import 'package:firstprojects/utils/storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/entry_field_widget.dart';
import 'choose_company_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //String _selectedLang = 'ar';
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  bool isNotValidate = false;
  bool isLoading = false;
  String validationText = '';

  @override
  void initState() {
    super.initState();
  }

  bool isSecure = true;
  void validate() async {
    validationText = '';
    isNotValidate = false;
    formKey.currentState!.validate();
    if (!isNotValidate) {
      try {
        setState(() {
          isLoading = true;
        });
        UserModel? user = await AuthCubit()
            .loginAction(_controllerEmail.text, _controllerPassword.text);
        setUser(user);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChooseCompanyScreen(user)));
      } on Exception catch (ex) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? DARK_GREY : LIGHT_GREY1,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(255, 53, 156, 239),
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
                  height: MediaQuery.of(context).size.height * 0.37 - 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                    color: Get.isDarkMode ? DARK_GREY : LIGHT_GREY1,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to the Wallet System'.tr,
                          style: GoogleFonts.ibmPlexSansArabic(
                            fontSize: 21,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Welcome. Start by joining our community".tr,
                          style: GoogleFonts.ibmPlexSansArabic(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AutofillGroup(
                            child: Column(children: [
                                EntryField(
                            isCenter: false,
                            autofill: const <String>[AutofillHints.email],
                                  suffix: IconButton(icon:const Icon( Icons.close,size: 15,), onPressed: () {
                                    _controllerEmail.clear();
                                  },),
                                  padding: const EdgeInsets.only(right: 15),
                            controller: _controllerEmail,
                            icon: const Icon(
                              Icons.person_outline_rounded,
                              size: 25,
                            ),
                            textInputAction: TextInputAction.next,
                            hint: 'E-mail'.tr,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                validationText = 'Please enter Email';
                                setState(() {
                                  isNotValidate = true;
                                });
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

   EntryField(
                         controller: _controllerPassword,
                         padding: const EdgeInsets.only(right: 15, ),
                         isSecure: isSecure,
                         isCenter: false,
                         autofill: const <String>[AutofillHints.password],
                         suffix: IconButton(icon:const Icon( Icons.close,size: 15,), onPressed: () {
                           _controllerPassword.clear();
                         },),
                         suffixIcon: IconButton(
                           onPressed: () {
                             setState(() {
                               isSecure = !isSecure;
                             });
                           },
                           icon: isSecure == true
                               ? const Icon(Icons.visibility_outlined,size: 20,)
                               : const Icon(Icons.visibility_off_outlined,size: 20,),
                         ),
                         icon: const Icon(
                           Icons.lock_outlined,
                           size: 25,
                         ),
                         hint: 'password'.tr,
                         validator: (text) {
                           if (text == null || text.isEmpty) {
                             validationText = 'This field is required'.tr;
                             setState(() {
                               isNotValidate = true;
                             });
                           } else if (text.length < 3) {
                             validationText =
                                 'It must contain at least 3 number'.tr;
                             setState(() {
                               isNotValidate = true;
                             });
                           }
                           return null;
                         },
                       ),
                        ])),


                        const SizedBox(
                          height: 5,
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
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  height: 50,
                                  width: 300,
                                  text: 'login'.tr,
                                  onTap: validate,
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Do not have an account'.tr,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              children: [
                                TextSpan(
                                  text: 'signUp'.tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen())),
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
