import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_assets.dart';
import 'package:movie_app/services/models/cast_crew.dart';

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
              child: Image.asset(
                ApplicationAssets.johhnWick,
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
