import 'package:flutter/material.dart';

class AppLocal{
  final Locale local;
  final String name;
  final String icon;
  final TextStyle? style;
  final String image;
  const AppLocal({
    this.style,
    required this.name,required this.image,
    required this.local,
    required this.icon,
});
}