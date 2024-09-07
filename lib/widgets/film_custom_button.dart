import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_colors.dart';

class FilmCustomButton extends StatelessWidget {
  const FilmCustomButton({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // Spread of the shadow
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 5), // Offset for bottom shadow (x, y)
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: ((size.width - 10) / 2),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: ApplicationColors.e00,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: ApplicationColors.f8f8,
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    "Watch Now",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ApplicationColors.f8f8,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: ((size.width - 10) / 2),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: ApplicationColors.f8f8,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.video_call_outlined,
                    color: ApplicationColors.e00,
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    "Watch Trailer",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ApplicationColors.e00,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
