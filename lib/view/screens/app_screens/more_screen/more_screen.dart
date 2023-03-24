import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../utils/colors.dart';
import '../../../bottom_navigation_screen.dart';
import '../../../widgets/app_bar_widget/custom_app_bar.dart';
import '../../../widgets/bottom_modal_sheet.dart';
import '../../auth_screens/change_password_screen.dart';
import '../../customers/visit_screen/visit_details_screen.dart';
import '../../printer_settings_screen.dart';
import '../../select_language_screen.dart';
import '../../select_theme.dart';
import 'widgets/bottom_more_screen.dart';
import 'widgets/menu_item_widget.dart';
import 'widgets/profile_more_screen_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';
  packageInf() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void initState() {
    packageInf();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode ? DARK_GREY2 : null,
        appBar: CustomAppBar(title: 'More'.tr),
        body: WillPopScope(
          onWillPop: () async {
            Get.offAll(BottomNavigationScreen(
              index: 0,
            ));
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ProfileMoreWidget(authController: AuthCubit()),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).cardColor),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      MenuItemWidget(
                          onTap: () {
                            ModalBottomSheet.moreModalBottomSheet(
                                context, const SelectLanguageScreen(), 350.h);
                          },
                          icon: Icon(
                            Icons.language,
                            size: 27,
                            color: Get.isDarkMode ? Colors.grey[600] : GREY,
                          ),
                          title: 'Change the language'.tr,
                          tail: Text(
                              '${Get.locale!.languageCode == 'ar' ? 'Arabic' : Get.locale!.languageCode == 'en' ? 'English' : ''}')),
                      SelectThemes(),
                      MenuItemWidget(
                        onTap: () {
                          Get.to(const PrinterSettingsScreen());
                        },
                        icon: Icon(
                          Icons.print,
                          size: 27,
                          color: Get.isDarkMode ? Colors.grey[600] : GREY,
                        ),
                        title: 'Printer settings'.tr,
                      ),
                      MenuItemWidget(
                        icon: Icon(
                          Icons.support_agent,
                          size: 27,
                          color: Get.isDarkMode ? Colors.grey[600] : GREY,
                        ),
                        title: 'Technical support'.tr,
                      ),
                      MenuItemWidget(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse('https://walleterp.com/'));
                          },
                          icon: Icon(
                            Icons.mobile_screen_share,
                            size: 27,
                            color: Get.isDarkMode ? Colors.grey[600] : GREY,
                          ),
                          title: 'Version number'.tr,
                          tail: Text(version)),
                      MenuItemWidget(
                        onTap: () {
                          Get.to(() => ChangePasswordScreen());
                        },
                        icon: Icon(
                          Icons.people,
                          size: 27,
                          color: Get.isDarkMode ? Colors.grey[600] : GREY,
                        ),
                        title: 'Change password'.tr,
                      ),
                      MenuItemWidget(
                        onTap: () async {
                          await launchUrl(Uri.parse("tel://06 200 6488"));
                        },
                        icon: Icon(
                          Icons.phone,
                          size: 27,
                          color: Get.isDarkMode ? Colors.grey[600] : GREY,
                        ),
                        title: 'Call us'.tr,
                      ),
                      InkWell(
                        onTap: () {
                          if( GetStorage().read('accountNo') == null){

                            showDialog(
                              context: context,

                              builder: (context) => AlertDialog(
                                backgroundColor:Get.isDarkMode?DARK_GREY2: Colors.white,
                                title: const Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    'Wallet ERP',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                content:
                                Text('Do you want to logout from App'.tr),
                                actions: <Widget>[
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      //<-- SEE HERE
                                      child: Text('NO'.tr),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => AuthCubit().logoutAction(),
                                    // <-- SEE HERE
                                    child: Text('YES'.tr),
                                  ),
                                ],
                              ),
                            );
                          }else{
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor:Get.isDarkMode?DARK_GREY2: Colors.white,

                              title: const Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  'Wallet ERP',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              content:
                                  const Text('لا يمكنك الغاء جولة'),
                              actions: <Widget>[

                                TextButton(
                                  onPressed: () => Get.to(VisitDetailsScreen(

                          )),
                                  // <-- SEE HERE
                                  child: Text('ok'.tr),
                                ),
                              ],
                            ),
                          );}
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.exit_to_app,
                                size: 27,
                                color: Colors.red,
                              ),
                              Text(
                                'Logout'.tr,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const BottomMoreScreen(),
              ],
            ),
          ),
        ));
  }
}
