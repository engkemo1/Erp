import 'dart:async';
import 'dart:io';
import 'package:firstprojects/controllers/app_controller.dart';
import 'package:firstprojects/controllers/cubit/cash_receipt_cubit/cash_receipt_cubit.dart';
import 'package:firstprojects/controllers/cubit/customer_cubit/customer_cubit.dart';
import 'package:firstprojects/models/app_local.dart';
import 'package:firstprojects/utils/colors.dart';
import 'package:firstprojects/utils/constants.dart';
import 'package:firstprojects/utils/translation.dart';
import 'package:firstprojects/view/screens/auth_screens/login_screen.dart';
import 'package:firstprojects/view/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:workmanager/workmanager.dart';
import 'controllers/cubit/auth_cubit/auth_cubit.dart';
import 'controllers/cubit/material_cubit/material_cubit.dart';
import 'controllers/cubit/stores_cubit/stores_cubit.dart';
import 'controllers/setting_controller.dart';
import 'controllers/theme_controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'view/onBoardingScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'view/bottom_navigation_screen.dart';

int? initScreen;
const fetchBackground = "fetchBackground";
@pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case fetchBackground:
//         AuthCubit().backgroundLoction();

//         break;
//     }
//     return Future.value(true);
//   });
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      connected = true;
    }
  } on SocketException catch (_) {
    connected = false;
  }
  await GetStorage.init();
//   AuthCubit().backgroundLoction();
  initScreen = GetStorage().read("initScreen");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var settingController = Get.put(SettingController());
  var version;
  packageInf() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    packageInf();
    configonesignle();

    // AuthCubit().checkVersion();
    // if (GetStorage().read("user") != null){

    //   Workmanager().initialize(
    //     callbackDispatcher,
    //     isInDebugMode: true,
    //   );

    //   Workmanager().registerPeriodicTask(
    //     "1",
    //     fetchBackground,
    //     frequency: const Duration(minutes: 15),
    //   );
    // }

    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    settingController.checkInternet();

    //  _run();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en');

    Get.put(AppController());
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MaterialCubit()..getCategoryItem()),
          BlocProvider(create: (context) => CustomerCubit()..getAllCustomers(1)),

        ],
    child: ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GlobalLoaderOverlay(
        child: GetMaterialApp(
            color: Colors.white,
            debugShowCheckedModeBanner: false,
            translations: Translation(),
            locale: const Locale('ar'),
            fallbackLocale: const Locale('ar'),
            title: 'WalletERP',
            theme: ThemesApp.light,
            darkTheme: ThemesApp.dark,
            themeMode: ThemeController().themeDataGet,
            // splash Screen
            home: AnimatedSplashScreen(
                duration: 1500,
                curve: Curves.easeInCirc,
                splash: Image.asset(
                  'assets/images/logo2.png',
                  height: 200,
                  width: 200,
                ),
                nextScreen: initScreen != 0
                    ? const OnBoardingScreen()
                    : GetStorage().read("user") == null
                        ? const LoginScreen()
                        : BottomNavigationScreen(),
                // splashTransition: SplashTransition.fadeTransition,
                splashTransition: SplashTransition.rotationTransition,
                // pageTransitionType: PageTransitionType.scale,
                backgroundColor: Color(0xff0C61CB))),
      ),
    ) );
  }

  void configonesignle() async {
    await OneSignal.shared
        .setAppId('NzVlOGM2OGYtYmE3Yy00YjcxLTg1YjYtNjdjZDU3ZmJhNWFi');
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;

      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        var data = result.notification.additionalData;
    
      });
    });

    //  void _handleSetEmail() {
    //   if (AuthCubit == null) return;

    //   print("Setting email");

    //   OneSignal.shared.setEmail(email:AuthCubit!).whenComplete(() {
    //     print("Successfully set email");
    //   }).catchError((error) {
    //     print("Failed to set email with error: $error");
    //   });
    // }
  }
}

//hello
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //TODO calling the force update API to check the new version.
    // YES => Go to Force Update Screen
    // No => Got to home page Screen.

    AppLocal? lang = GetStorage().read('lang') as AppLocal?; //fff
    // if (lang != null) {
    //   Get.updateLocale(lang.local);
    // } else {
    //   //  Get.to(SelectLanguageScreen());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.textColor2,
      body: Image.network(
          'https://play-lh.googleusercontent.com/bU10hE1RfJqD-E8eKPDKQ4nC-R5puLMefcKZYQm3YStp0wWI1DVAjSM8kNSKiuo4plQ=w240-h480-rw'),
    );
  }
}
