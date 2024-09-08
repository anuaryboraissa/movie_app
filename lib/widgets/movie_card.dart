import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/services/models/movie.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_utils.dart';

class Moviecard extends StatelessWidget {
  const Moviecard({super.key, required this.size, required this.movie});
  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      // padding: const EdgeInsets.all(8),
      height: 120,
      width: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ApplicationAssets.img1,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ApplicationColors.a26.withOpacity(.8),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                          child: Text(
                        "X",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ApplicationColors.f8f8,
                        ),
                      )),
                    ))),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const LinearProgressIndicator(
                      value: .6,
                      backgroundColor: ApplicationColors.f8f8,
                      color: ApplicationColors.e00,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                size: 35,
                                color:ApplicationColors.f8f8
                              )),
                          Text(
                            "1:26:53",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ApplicationColors.f8f8,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
