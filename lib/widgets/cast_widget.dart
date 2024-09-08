import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_assets.dart';
import 'package:movie_app/services/models/cast_crew.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_utils.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key, required this.size, required this.castCrew});
  final Size size;
  final CastCrew castCrew;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 125,
      height: 125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl:
                    "${ApplicationStrings.imageDomain}${castCrew.profilePath}",
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
                  ApplicationAssets.img7,
                  fit: BoxFit.cover,
                ),
                fadeInDuration: const Duration(milliseconds: 500),
                // width: 300,
                // height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "${castCrew.knownForDepartment}",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            "${castCrew.name}",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          )
        ],
      ),
    );
  }
}
