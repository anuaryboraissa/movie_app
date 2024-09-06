import 'package:flutter/material.dart';
import 'package:movie_app/constants/app_utils.dart';

class AuthSocilaLogins extends StatelessWidget {
  final String logo;

  const AuthSocilaLogins({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height:50,
      width: 50,
      decoration: BoxDecoration(
        color: ApplicationUtils.getTheme(context).colorScheme.background,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.07,
          child: Image.asset(
            logo,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
