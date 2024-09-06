import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_colors.dart';

import '../constants/app_assets.dart';

class FilmographyCard extends StatelessWidget {
  const FilmographyCard({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * .2,
      width: size.width * .72,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ApplicationAssets.johhnWick,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: size.width * .72,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ApplicationColors.a26.withOpacity(.7),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    "Role: Gamora ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ApplicationColors.baoa,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Guardian of the Galaxy Vol. 3 ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ApplicationColors.f8f8,
                    ),
                  ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
