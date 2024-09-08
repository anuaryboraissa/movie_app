import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../constants/app_assets.dart';
import '../constants/app_strings.dart';
import '../services/models/movie.dart';

class TrendingNowCard extends StatelessWidget {
  const TrendingNowCard({super.key, required this.size, required this.movie});
  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 130,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl:
                    "${ApplicationStrings.imageDomain}${movie.backdropPath}",
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
                  ApplicationAssets.img3,
                  fit: BoxFit.cover,
                ),
                fadeInDuration: const Duration(milliseconds: 500),
                // width: 300,
                // height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 1,
                right: 1,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: ApplicationColors.a26.withOpacity(.8),
                      borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector(
                      onTap: () {
                        debugPrint("Book");
                      },
                      child: const Center(
                          child: Icon(
                        Icons.bookmark,
                        color: ApplicationColors.f8f8,
                      ))),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ApplicationColors.a26.withOpacity(.7),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Center(
                      child: Text(
                    "${movie.originalTitle} ",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ApplicationColors.f8f8,
                    ),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
