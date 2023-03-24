
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageController{


 static imageAsset(String image,double? height ,double? width){
    return Image.asset('assets/images/$image',height: height??null,width: width??null,);
  }
 static svgPictures(String image,double? height ,double? width){
   return SvgPicture.asset('assets/images/$image',height: height??null,width: width??null,);
 }
 static imageNetwork(String image,double? height ,double? width){
   return Image.network(image,height: height??null,width: width??null,);
 }}