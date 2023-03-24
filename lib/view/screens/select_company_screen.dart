import 'package:firstprojects/models/user/user.dart';
import '../bottom_navigation_screen.dart';
import 'package:firstprojects/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/app_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../widgets/custom_button.dart';

class SelectCompanyScreen extends StatefulWidget {
  UserModel? user;
  SelectCompanyScreen(this.user);
  @override
  _SelectCompanyScreenState createState() => _SelectCompanyScreenState();
}

class _SelectCompanyScreenState extends State<SelectCompanyScreen> {
  late List<UserCompany> companies;
  UserCompany? selectedCompany;
  List<BranchElement> branches = [];
  BranchElement? selectedBranch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companies = getUser()!.userCompanies!;
    // selectedCompany=companies[0];
    // selectedBranch=branches[0];
    appController = Get.find();
  }

  late AppController appController;
  Future loginAction(String email, String password) async {
    try {
      String url =
          "http://dev.accountly.me:3000/users/login?email=$email&password=$password";

      var response = await http.post(Uri.parse(url), body: {
        "email": email,
        "password": md5.convert(utf8.encode(password)).toString()
      });
      var responsebody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
            (_) => false);
      } else {
        throw Exception(responsebody['message']);
      }

      // print(responsebody['username']);
      //print(responsebody);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 53, 156, 239),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 53, 156, 239),
            child: Image.network(
              'https://www.emaratalyoum.com/polopoly_fs/1.1574371.1639486949!/image/image.jpeg',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Companies'.tr,
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: Colors.blue,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_drop_down),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<UserCompany?>(
                                      icon: Container(),
                                      underline: null,
                                      value: selectedCompany,
                                      items: [
                                        ...companies.map((e) =>
                                            DropdownMenuItem<UserCompany?>(
                                              child: Text(
                                                  e.company?.companyName ?? ''),
                                              value: e,
                                            ))
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          selectedCompany = val;
                                          appController.userCompany.value =
                                              selectedCompany!;
                                          branches = selectedCompany!
                                              .company!.branches!;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Branch'.tr,
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: Colors.blue,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_drop_down),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: selectedCompany == null
                                      ? const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 10),
                                          child: Text('select company first'),
                                        )
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton<BranchElement>(
                                              icon: Container(),
                                              value: selectedBranch,
                                              items: [
                                                ...branches.map((e) =>
                                                    DropdownMenuItem<
                                                        BranchElement>(
                                                      child:
                                                          Text(e.nameAr ?? ''),
                                                      value: e,
                                                    ))
                                              ],
                                              onChanged: (val) {
                                                setState(() {
                                                  print('tapped');
                                                  selectedBranch = val;
                                                });
                                              }),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationScreen())),
                            height: 50,
                            width: 300,
                            text: 'login'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
