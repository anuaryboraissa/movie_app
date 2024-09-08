import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: ApplicationColors.a26.withOpacity(.8),
            borderRadius: BorderRadius.circular(50)),
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
                child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ApplicationColors.f8f8,
            ))),
      ),
    );
  }
}
