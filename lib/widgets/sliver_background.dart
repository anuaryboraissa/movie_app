import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_strings.dart';
import 'package:movie_app/services/models/genre.dart';
import 'package:movie_app/services/models/movie.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'custom_button.dart';
import 'rating_widget.dart';
import 'top_categories.dart';

class SliverBackground extends StatelessWidget {
  const SliverBackground(
      {super.key,
      required this.isSliverAppBarExpanded,
      required this.size,
      required this.movie, required this.genres});
  final bool isSliverAppBarExpanded;
  final Size size;
  final Movie movie;
  final List<Genre> genres;

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
        // Positioned.fill(
        //   child: CachedNetworkImage(
        //     imageUrl: "${ApplicationStrings.imageDomain}${movie.backdropPath}",
        //     placeholder: (context, url) => const CircularProgressIndicator(),
        //     errorWidget: (context, url, error) => const Icon(Icons.error),
        //     fadeInDuration: const Duration(milliseconds: 500),
        //     // width: 300,
        //     // height: 300,
        //     fit: BoxFit.cover,
        //   ),
        // ),
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
                RatingWidget(
                    rating: double.parse(
                        movie.voteAverage!.toStringAsFixed(1).toString()),
                    size: size),
                SizedBox(height: 5.h),
                Text(
                  "${movie.originalTitle}",
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ApplicationColors.f8f8,
                  ),
                ),
                SizedBox(height: 5.h),
                TopCategory(
                  width: 290,
                  size: size,
                  categories: ((genres.length > 3
                          ? genres.sublist(0, 3)
                          :genres))
                      .map((e) {
                    if ((genres).indexOf(e) ==
                        (genres.length - 1)) {
                          debugPrint("Called! ${genres.length}=========? ");
                      return Text(
                        "${e.name}",
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.montserrat(

                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ApplicationColors.f8f8,
                          
                        ),
                      );
                    } else {
                      return Row(
                        children: [
                          Text(
                            "${e.name}",
                             overflow: TextOverflow.clip,
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
                        ],
                      );
                    }
                  }).toList(),

                  // firstCategory: Text(
                  //   "Action",
                  //   style: GoogleFonts.montserrat(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //     color: ApplicationColors.f8f8,
                  //   ),
                  // ),
                  // secondCategory: Text(
                  //   "Adventure",
                  //   style: GoogleFonts.montserrat(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //     color: ApplicationColors.f8f8,
                  //   ),
                  // ),
                  // lastCategory: Text(
                  //   "Fantasy",
                  //   style: GoogleFonts.montserrat(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //     color: ApplicationColors.f8f8,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
