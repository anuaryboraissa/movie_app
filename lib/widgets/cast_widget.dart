import 'package:flutter/material.dart';
import 'package:movie_app/constants/app_assets.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: size.width * .31,
      height: size.height * .22,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * .3,
            height: size.width * .3,
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
          const Text("Actor"),
          const Text("Sam Wothington")
        ],
      ),
    );
  }
}
