import 'package:firstprojects/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'screens/auth_screens/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    int initScreen = 0;
    GetStorage().write('initScreen', initScreen);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Constants.primaryColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      isTopSafeArea: true,
      key: introKey,

      globalBackgroundColor: Constants.primaryColor,

      globalHeader: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
            child: InkWell(
          child: Text(
            'Skip'.tr,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          onTap: () {
            _onIntroEnd(context);
          },
        )),
      ),
      pages: [
        PageViewModel(
          bodyWidget: Container(),
          titleWidget: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'All in One'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp),
                  textAlign: TextAlign.end,
                ),
                Text(
                  '''
                  
                  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has
                  ''',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xff5e6c84), fontSize: 16.sp),
                ),
              ],
            ),
          ),
          image: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, bottom: 30),
                child: _buildImage('assets/images/logo.svg', 60),
              ),
              Container(
                width: 370.w,
                height: 260.h,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white12),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/images/print-mdpi.svg',
                )),
              )
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          bodyWidget: Container(),
          titleWidget: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Live Tracking',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                  textAlign: TextAlign.end,
                ),
                Text(
                  '''
                  
                  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has
                  ''',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xff5e6c84), fontSize: 16.sp),
                ),
              ],
            ),
          ),
          image: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, bottom: 30),
                child: _buildImage('assets/images/logo.svg', 60),
              ),
              Container(
                width: 370.w,
                height: 260.h,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white12),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/images/print-mdpi.svg',
                )),
              )
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          bodyWidget: Container(),
          titleWidget: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Real time transaction',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                  textAlign: TextAlign.end,
                ),
                Text(
                  '''
                  
                  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has
                  ''',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xff5e6c84), fontSize: 16.sp),
                ),
              ],
            ),
          ),
          image: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, bottom: 30),
                child: _buildImage('assets/images/logo.svg', 60),
              ),
              Container(
                width: 370.w,
                height: 260.h,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white12),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/images/onboarding2-mdpi.svg',
                )),
              )
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          bodyWidget: Container(),
          titleWidget: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Offline mode',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                  textAlign: TextAlign.end,
                ),
                Text(
                  '''
                  
                  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has
                  ''',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xff5e6c84), fontSize: 16.sp),
                ),
              ],
            ),
          ),
          image: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, bottom: 30),
                child: _buildImage('assets/images/logo.svg', 60),
              ),
              Container(
                width: 370.w,
                height: 260.h,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white12),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/images/onboarding4-mdpi.svg',
                )),
              )
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
