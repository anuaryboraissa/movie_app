import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_assets.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:movie_app/stm/sign_in_provider.dart';
import 'package:movie_app/widgets/auth_social_login.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark),
          child: Consumer<SignInProvider>(builder: (context, provider, _) {
            debugPrint("Status: ${provider.user} ================> ");
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (provider.user != null && provider.user!["success"]) {
                Fluttertoast.showToast(
                    msg:
                        "Authenticated as ${(provider.user!["user"] as User).displayName}");
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const DashBoardScreen()));
              }
            });
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: ApplicationColors.d30.withOpacity(.8),
                    image: const DecorationImage(
                      image: AssetImage(ApplicationAssets.movieBg),
                      fit: BoxFit.cover, // Makes the image fit the whole screen
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black
                      .withOpacity(0.8), // Change opacity and color here
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height *
                            .95, // Set minimum height to screen height
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Skip",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: ApplicationColors.baoa,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Text.rich(TextSpan(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: ApplicationColors.f8f8,
                                    ),
                                    text: "Welcome to ",
                                    children: [
                                      TextSpan(
                                        text: "Movie Magic",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17,
                                          // fontWeight: FontWeight.bold,
                                          color: ApplicationColors.e00,
                                        ),
                                      )
                                    ])),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     PageTransition(
                                    //         type:
                                    //             PageTransitionType.rightToLeft,
                                    //         child: const DashBoardScreen()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ApplicationColors.e00),
                                    child: Center(
                                        child: Text(
                                      "Sign In With Password",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ApplicationColors.f8f8,
                                      ),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Expanded(
                                        child: Divider(
                                      color: ApplicationColors.baoa,
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Or Continue With",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: ApplicationColors.baoa,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                        child: Divider(
                                      color: ApplicationColors.baoa,
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: const AuthSocilaLogins(
                                        logo: ApplicationAssets.facebook,
                                      ),
                                    ),
                                    provider.signInAttempt
                                        ? const NutsActivityIndicator(
                                            activeColor: ApplicationColors.e00,
                                            inactiveColor:
                                                ApplicationColors.e7e7,
                                            tickCount: 24,
                                            relativeWidth: 0.4,
                                            radius: 15,
                                            startRatio: 0.7,
                                            animationDuration:
                                                Duration(milliseconds: 500),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              provider.signIn();
                                            },
                                            child: const AuthSocilaLogins(
                                              logo: ApplicationAssets.google,
                                            ),
                                          ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const AuthSocilaLogins(
                                        logo: ApplicationAssets.apple,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * .07,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account? ",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ApplicationColors.baoa,
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Sign up",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }
}
