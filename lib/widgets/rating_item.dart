import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class RatingSubItem extends StatelessWidget {
  const RatingSubItem({super.key, required this.rating, required this.size});
  final double rating;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
             SizedBox(
              width: size.width*.02,
            ),
            Text(
              "$rating",
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ApplicationColors.f8f8),
            )
          ],
        );
  }
}