import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/widgets/custom_back_button.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class ActorTopBackground extends StatelessWidget {
  const ActorTopBackground({super.key, required this.size, required this.top});
  final Size size;
  final int top;

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
          bottom: 4,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            // color: Colors.black.withOpacity(0.5), // Optional background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ApplicationColors.d30.withOpacity(.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text.rich(TextSpan(
                        text: "Top $top ",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ApplicationColors.f8f8,
                        ),
                        children: [
                          TextSpan(
                            text: "IMDb",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ApplicationColors.baoa,
                            ),
                          )
                        ])),
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
