import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'rating_item.dart';
import 'top_categories.dart';

class FilmSliverBackground extends StatelessWidget {
  const FilmSliverBackground(
      {super.key,
      required this.isSliverAppBarExpanded,
      required this.size,
      required this.rating,
      required this.releaseYear,
      required this.reviewsNumber});
  final bool isSliverAppBarExpanded;
  final Size size;
  final double rating;
  final String releaseYear;
  final int reviewsNumber;

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
          bottom: 60,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            // color: Colors.black.withOpacity(0.5), // Optional background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopCategory(
                  width: 180,
                  size: size,
                  categories: [
                    RatingSubItem(rating: rating, size: size),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    IntrinsicHeight(
                      child: Container(
                        height: 15,
                        width: 1.5.w,
                        color: ApplicationColors.baoa,
                      ),
                    ),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    Text(
                      releaseYear,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ApplicationColors.f8f8,
                      ),
                    ),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    IntrinsicHeight(
                      child: Container(
                        height: 15,
                        width: 1.5.w,
                        color: ApplicationColors.baoa,
                      ),
                    ),
                    SizedBox(
                      width: size.width * .02,
                    ),
                    Text(
                      reviewsNumber > 12 ? "12+" : "$reviewsNumber",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ApplicationColors.f8f8,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
