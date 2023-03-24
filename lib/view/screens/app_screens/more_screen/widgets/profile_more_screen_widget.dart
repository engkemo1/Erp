import 'dart:io';
import 'package:firstprojects/controllers/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstprojects/utils/constants.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/storage.dart';

class ProfileMoreWidget extends StatelessWidget {
  ProfileMoreWidget({
    Key? key,
    required this.authController,
  }) : super(key: key);

  AuthCubit authController = AuthCubit();
  final ImagePicker picker = ImagePicker();
  File? profileImage;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).cardColor),
        //  padding:
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          leading: InkWell(
            onTap: () {
              getImage(context);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                profileImage == null
                    ? CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          getUser()!.profilePicture ?? "",
                        ),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(
                          profileImage!,
                        ),
                      ),
                Positioned.directional(
                    textDirection: TextDirection.ltr,
                    start: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: const Icon(
                        Icons.edit,
                        size: 10,
                      ),
                    ),
                    ),
              ],
            ),
          ),
          title: Text(
            '${getUser()!.userRole!.nameEn}',
            style: TextStyle(
                color: Get.isDarkMode ? Colors.grey[300] : Colors.blue[900],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${getUser()!.email}',
            style: TextStyle(
                color: Get.isDarkMode ? Colors.grey : Colors.blue[600],
                fontSize: 12),
          ),
        ));
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
                                    //    Icons.browse_gallery,
                                    Icons.photo_album,
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
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Constants.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel'.tr,
                                    style: TextStyle(color: Colors.white),
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
            // File rotatedImage =
            // await FlutterExifRotation.rotateImage(path: pickedFile.path);

            profileImage = File(pickedFile.path);
            authController.uploadImage(imagePath: pickedFile.path);
          } else {
            print('No image selected.');
          }
        }
      }
    });
  }

  clearImage() {
    profileImage = null;
  }
}
