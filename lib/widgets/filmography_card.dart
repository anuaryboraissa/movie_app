import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../constants/app_assets.dart';
import '../constants/app_strings.dart';
import '../constants/app_utils.dart';
import '../services/models/actor_philmography.dart';

class FilmographyCard extends StatelessWidget {
  const FilmographyCard(
      {super.key, required this.size, required this.philmography});
  final Size size;
  final ActorPhilmography philmography;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * .2,
      //  height: 120,
      width: 290,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: "${ApplicationStrings.imageDomain}${philmography.backdropPath}",
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                      height: 40,
                      width: 40,
                      child: NutsActivityIndicator(
                        activeColor: ApplicationColors.e00,
                        inactiveColor: ApplicationColors.e7e7,
                        tickCount: 24,
                        relativeWidth: 0.4,
                        radius: 15,
                        startRatio: 0.7,
                        animationDuration: Duration(milliseconds: 500),
                      )),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ApplicationAssets.img4,
                  fit: BoxFit.cover,
                ),
                fadeInDuration: const Duration(milliseconds: 500),
                // width: 300,
                // height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 290,
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
                        "Character: ${philmography.character} ",
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
                        "${philmography.originalTitle} ",
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
