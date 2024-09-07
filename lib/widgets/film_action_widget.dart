import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class FilmActionWidget extends StatelessWidget {
  const FilmActionWidget({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Row(
                children: const [
                  Icon(Icons.thumb_up_alt_outlined),
                  SizedBox(
                    width: 3,
                  ),
                  Text("264")
                ],
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
              Row(
                children: const [
                  Icon(Icons.thumb_down_alt_outlined),
                  SizedBox(
                    width: 3,
                  ),
                  Text("103")
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(50)),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Icon(
                    Icons.bookmark,
                    color: Theme.of(context).colorScheme.onBackground,
                  ))),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(50)),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:  Center(
                      child: Icon(
                    Icons.forward_10_outlined,
                    color: Theme.of(context).colorScheme.onBackground,
                  ))),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: ApplicationColors.e00,
                  borderRadius: BorderRadius.circular(50)),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child: Icon(
                    Icons.download,
                    color: ApplicationColors.f8f8,
                  ))),
            )
          ],
        )
      ],
    );
  }
}
