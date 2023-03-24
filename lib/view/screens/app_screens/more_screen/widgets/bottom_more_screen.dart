import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BottomMoreScreen extends StatefulWidget {
  const BottomMoreScreen({Key? key}) : super(key: key);

  @override
  State<BottomMoreScreen> createState() => _BottomMoreScreenState();
}

class _BottomMoreScreenState extends State<BottomMoreScreen> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';
  packageInf() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  @override
  void initState() {
    packageInf();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'walletErp',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.network(
              'https://play-lh.googleusercontent.com/hVM7wz_1vPCWJS3mdVjYifaabNaiC899Q0Z4yOdoz7Iwpiuz1QnYYcoFGVqV0TndJDA9',
              height: 30,
              width: 30,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${DateTime.now().year} Wallet ERP.Design with love in Amman',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
