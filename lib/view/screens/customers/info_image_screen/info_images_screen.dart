import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../../../controllers/cubit/customer_cubit/customer_cubit.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class InfoImagesScreen extends StatefulWidget {
  const InfoImagesScreen({Key? key}) : super(key: key);

  @override
  _InfoImagesScreenState createState() => _InfoImagesScreenState();
}

class _InfoImagesScreenState extends State<InfoImagesScreen> {
  File? selectedFile;
  final ImagePicker picker = ImagePicker();

  // List<File>images=[];
  var customerController = CustomerCubit();
  List<String> imagesUrls = [];
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Color(0xffA1C1E0),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 2,
        title: Text(
          'Take a picture of the information'.tr,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: imagesUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 1),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        backgroundColor:
                            Get.isDarkMode ? DARK_GREY3 : Colors.white,
                        title: 'Choose Action?'.tr,
                        content: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 25),
                              InkWell(
                                onTap: () {
                                  Get.to(() => Scaffold(
                                          body: Center(
                                        child: Image.network(
                                          imagesUrls[index],
                                          width: Get.width,
                                          height: Get.height,
                                          fit: BoxFit.contain,
                                        ),
                                      )));
                                },
                                child: Text(
                                  'view'.tr,
                                  style: const TextStyle(
                                      color: Constants.primaryColor),
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {
                                  removeImageFromList(index);
                                  Get.back();
                                },
                                child: Text(
                                  'Delete'.tr,
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                  child: Image.network(imagesUrls[index]),
                );
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          getImage(context);
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  removeImageFromList(index) {
    imagesUrls.removeAt(index);
    setState(() {});
  }

  Future getImage(context) async {
    ImageSource source;
    showModalBottomSheet(
        context: context,
        backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
        builder: (context) {
          return BottomSheet(
            backgroundColor: Get.isDarkMode ? DARK_GREY3 : Colors.white,
            elevation: 0,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? DARK_GREY3 : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop(ImageSource.camera);
                            },
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.09),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Theme.of(context).primaryColor,
                                  )),
                            ),
                            title: Text(
                              'Camera'.tr,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Constants.textColor),
                            ),
                            subtitle: Text(
                              'Open Camera To Capture Photo'.tr,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop(ImageSource.gallery);
                            },
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.09),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.browse_gallery,
                                    color: Theme.of(context).primaryColor,
                                  )),
                            ),
                            title: Text(
                              'Gallery'.tr,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Constants.textColor),
                            ),
                            subtitle: Text(
                              'Explore Gallary'.tr,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30.w),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Constants.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            onClosing: () {},
          );
        }).then((value) async {
      if (value != null) {
        if (value is ImageSource) {
          source = (value as ImageSource);

          final pickedFile = await picker.getImage(
              source: source, maxHeight: 150, maxWidth: 150, imageQuality: 50);

          if (pickedFile != null) {
            selectedFile = File(pickedFile.path);
            images.add(selectedFile!);
            CustomerCubit()
                .uploadImage(imagePath: pickedFile.path)
                .then((value) {
              imagesUrls.add(value);
              setState(() {});
            });
          } else {
            print('No image selected.');
          }
        }
      }
    });
  }
}
