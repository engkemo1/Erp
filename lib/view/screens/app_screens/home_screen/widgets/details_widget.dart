import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DetailsWidget extends StatelessWidget {
  final String title;
  final String imagePath;

  final bool isSelected;

  final Function()? onTap;

  final Color color;

  const DetailsWidget(
      {Key? key,
        required this.title,
        this.onTap,
        required this.color,
        this.isSelected = false, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1 : 0.3,
        child: Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                height: 24.h,width: 24.w,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(imagePath),
                )
            ),
          ],
        ),
      ),
    );
  }
}
