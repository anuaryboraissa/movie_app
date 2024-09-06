import 'package:flutter/material.dart';
import 'package:movie_app/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.callback, required this.size});
  final Function()? callback;
  final Size size;

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //       style: ElevatedButton.styleFrom(
    //           backgroundColor: Theme.of(context).colorScheme.primary,
    //           minimumSize: size,
    //           padding: const EdgeInsets.only(bottom: 5,top: 5),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(25))),
    //       onPressed: callback,
    //       child: const Icon(
    //         Icons.play_arrow_rounded,
    //         color: ApplicationColors.f8f8,
    //         size: 35,
    //       ));
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: ApplicationColors.e00,
        ),
        child: const Center(
          child: Icon(
            Icons.play_arrow_rounded,
            size: 35,
            color: ApplicationColors.f8f8,
          ),
        ),
      ),
    );
  }
}
