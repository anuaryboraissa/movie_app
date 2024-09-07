import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/constants/app_colors.dart';

class TopCategory extends StatelessWidget {
  const TopCategory(
      {super.key,
      required this.categories,
      required this.size,
      required this.width});

  final List<Widget> categories;
  final Size size;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ApplicationColors.d30.withOpacity(.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // children: [
         
        //   secondCategory,
        //   SizedBox(
        //     width: size.width * .02,
        //   ),
        //   IntrinsicHeight(
        //     child: Container(
        //       height: 15,
        //       width: 1.5.w,
        //       color: ApplicationColors.baoa,
        //     ),
        //   ),
        //   SizedBox(
        //     width: size.width * .02,
        //   ),
        //   lastCategory
        // ],
        children: categories,
      ),
    );
  }
}
