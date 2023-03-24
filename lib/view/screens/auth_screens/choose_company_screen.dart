import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:firstprojects/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/app_controller.dart';
import '../../../models/user/user.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../bottom_navigation_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/selectable_entry_field.dart';

class ChooseCompanyScreen extends StatefulWidget {
  UserModel? user;

  ChooseCompanyScreen(this.user);

  @override
  _ChooseCompanyScreenState createState() => _ChooseCompanyScreenState();
}

class _ChooseCompanyScreenState extends State<ChooseCompanyScreen> {
  late List<UserCompany> companies;
  UserCompany? selectedCompany;
  List<BranchElement> branches = [];

  BranchElement? selectedBranch;

  @override
  void initState() {
    super.initState();
    companies = widget.user!.userCompanies!;
    selectedCompany = companies[0];
    branches = selectedCompany!.company!.branches!;
    selectedBranch = branches[0];
    appController = Get.find();
  }

  late AppController appController;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Get.isDarkMode ? DARK_GREY : LIGHT_GREY1,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
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
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //  Text(
                    //  'walletErp',
                    //  style: TextStyle(
                    //      color: Colors.white,
                    //      fontSize: 16,
                    //     fontWeight: FontWeight.bold),
                    //  )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6 - 50,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Company'.tr,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: Colors.blue,
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      SelectableEntryField<UserCompany>(
                        isCenter: true,
                        enableOnTab: true,
                        color: Get.isDarkMode ? Constants.textColor : Colors.white,


                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 5.w),
                        valueWeight: FontWeight.w500,
                        hasTitle: false,
                        hasBorder: true,
                        hint: 'The Company name'.tr,
                        valueColor:
                            Get.isDarkMode ? Colors.white : Colors.white,
                        hintStyle: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp),
                        items: companies,
                        textValue: (val) => val.company?.companyName ?? '',
                        hasValue: true,
                        onSelect: (val) {
                          setState(() {
                            selectedCompany = val;
                            appController.userCompany.value = selectedCompany!;
                            branches = selectedCompany!.company!.branches!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Branch'.tr,
                        style: GoogleFonts.ibmPlexSansArabic(
                          color: Colors.blue,
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: selectedCompany == null
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 5),
                                      // child: Text('select company first'),
                                    )
                                  : SelectableEntryField<BranchElement>(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 5.w),
                                      isCenter: true,
                                      enableOnTab: true,
                                      hasValue: true,
                                color: Get.isDarkMode ? Constants.textColor : Colors.white,

                                hasBorder: true,
                                      hint: 'Branch'.tr,
                                      hintStyle: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                      valueColor: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.white,
                                      valueWeight: FontWeight.w500,
                                      items: branches,
                                      hasTitle: false,
                                      textValue: (val) => val.nameAr ?? '',
                                      onSelect: (val) {
                                        setState(() {
                                          // print('tapped');
                                          selectedBranch = val;
                                        });
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onTap: () {
                                  select();
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //      const BottomNavigationPage()));
                                },
                                height: 50,
                                width: 280,
                                text: 'login'.tr,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )));
  }

  Future select() async {
    if (selectedCompany == null || selectedBranch == null) {
      print('you should select the company and branch first');
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      String token = await AuthCubit().selectCompanyAndBranch(
          selectedCompany!.companyId!, selectedBranch!.id!);
      setToken(token);
      Get.to(BottomNavigationScreen());
      setState(() {
        isLoading = false;
      });
    } on Exception catch (ex) {
      print(ex.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
}
