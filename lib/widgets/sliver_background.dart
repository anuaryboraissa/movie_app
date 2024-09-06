import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'custom_button.dart';
import 'rating_widget.dart';
import 'top_categories.dart';

class SliverBackground extends StatelessWidget {
  const SliverBackground(
      {super.key, required this.isSliverAppBarExpanded, required this.size});
  final bool isSliverAppBarExpanded;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ApplicationAssets.johhnWick,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            // color: Colors.black.withOpacity(0.5), // Optional background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 RatingWidget(rating: 7.5,size: size),
                SizedBox(height: 5.h),
                Text(
                  "Doctor Strange",
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ApplicationColors.f8f8,
                  ),
                ),
                SizedBox(height: 5.h),
                TopCategory(
                  width: 240,
                  size: size,
                  firstCategory: Text(
                    "Action",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.f8f8,
                    ),
                  ),
                  secondCategory: Text(
                    "Adventure",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.f8f8,
                    ),
                  ),
                  lastCategory: Text(
                    "Fantasy",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.f8f8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
       
      ],
    );
  }
}
