import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'custom_button.dart';
import 'film_custom_button.dart';
import 'rating_item.dart';
import 'top_categories.dart';

class FilmSliverBackground extends StatelessWidget {
  const FilmSliverBackground(
      {super.key,
      required this.isSliverAppBarExpanded,
      required this.size,
      required this.rating});
  final bool isSliverAppBarExpanded;
  final Size size;
  final double rating;

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
                TopCategory(
                  width: 180,
                  size: size,
                  firstCategory: RatingSubItem(rating: rating, size: size),
                  secondCategory: Text(
                    "2023",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.f8f8,
                    ),
                  ),
                  lastCategory: Text(
                    "12+",
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
