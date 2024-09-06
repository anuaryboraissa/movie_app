import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:movie_app/widgets/rating_item.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating, required this.size});
  final double rating;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ApplicationColors.d30.withOpacity(.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: RatingSubItem(rating: rating, size: size),
      ),
    );
  }
}
