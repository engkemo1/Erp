import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
class ImageView extends StatelessWidget {
 final String imageUrl;
  const ImageView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
       ),
      body:  Container(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
          )
      )
    );
  }
}
