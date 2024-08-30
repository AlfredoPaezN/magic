import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magic/src/presentation/utils/colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.description,
    super.key,
    this.trailing,
    this.data,
    this.color,
    this.height,
    this.width,
  });

  final Widget? trailing;
  final Widget description;
  final Widget? data;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 130.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(MagicColors.secondary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          data ?? Container(),
          description,
        ],
      ),
    );
  }
}
