import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../services/models/person_image.dart';

class ActorTopBackground extends StatelessWidget {
  const ActorTopBackground(
      {super.key, required this.size, required this.image});
  final Size size;
  final PersonImage image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: "${ApplicationStrings.imageDomain}${image.filePath}",
            placeholder: (context, url) => const Center(
              child: SizedBox(
                  height: 40, width: 40, child: NutsActivityIndicator(
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
              ApplicationAssets.img5,
              fit: BoxFit.cover,
            ),
            fadeInDuration: const Duration(milliseconds: 500),
            // width: 300,
            // height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
