import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:readmore/readmore.dart';

import '../constants/app_colors.dart';
import '../widgets/actor_top_background.dart';
import '../widgets/filmography_card.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({super.key});

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  @override
  PageController _pageController = PageController();
  int currentPage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Fully transparent status bar
          statusBarIconBrightness: ApplicationUtils.isDarkTheme(context)
              ? Brightness.light
              : Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness:
              Brightness.dark, // Status bar icons for dark background
        ),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: size.height * .3,
                  width: size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: 6,
                          controller: _pageController,
                          onPageChanged: (value) {
                            currentPage = value;
                            setState(() {});
                          },
                          itemBuilder: (context, index) {
                            return ActorTopBackground(top: 107, size: size);
                          },
                        ),
                        Positioned(
                          top: 30,
                          left: 10,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: 40,
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    color:
                                        ApplicationColors.a26.withOpacity(.8),
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
                              )),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            width: 130,
                            child: DotsIndicator(
                              dotsCount: 6,
                              position: currentPage,
                              decorator: DotsDecorator(
                                color: ApplicationColors.baoa,
                                activeColor: ApplicationColors.f8f8,
                                size: const Size.square(9.0),
                                // activeSize: Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: size.height * .3,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Action",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // color: ApplicationColors.f8f8,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.circle,
                                size: 5,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Adventure",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // color: ApplicationColors.f8f8,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.circle,
                                size: 5,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Fantasy",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // color: ApplicationColors.f8f8,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "July 26, 2017",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              // color: ApplicationColors.f8f8,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "AVATAR: THE WAY OF WATER",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          // color: ApplicationColors.f8f8,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ReadMoreText(
                        "The film stars Sam Worthington as Jake Sully, a disabled Marine who has been sent to Pandora to assist Earth's Resources Development Administration (RDA) in its search for an exotic substance called “unobtanium.” Because Pandora's atmosphere is toxic to humans, and because the planet is inhabited by a large humanoid,a disabled Marine who has been sent to Pandora to assist Earth's Resources Development Administration (RDA) in its search for an exotic substance called “unobtanium.” Because Pandora's atmosphere is toxic to humans, and because the planet is inhabited by a large humanoid",
                        trimMode: TrimMode.Line,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          // color: ApplicationColors.e00,
                        ),
                        trimLines: 6,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: ' More',
                        trimExpandedText: ' Less',
                        moreStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ApplicationColors.baoa,
                        ),
                        lessStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                         color: ApplicationColors.baoa,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Filmography",
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) =>
                                FilmographyCard(size: size),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Quick Facts",
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          // color: ApplicationColors.f8f8,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ),
                          text: "Birth City: ",
                          children: [
                            TextSpan(
                              text: "Passaic",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                // color: ApplicationColors.f8f8,
                              ),
                            )
                          ])),
                      const SizedBox(
                        height: 4,
                      ),
                      Text.rich(TextSpan(
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ),
                          text: "Birth Country: ",
                          children: [
                            TextSpan(
                              text: "United States",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                // color: ApplicationColors.f8f8,
                              ),
                            )
                          ])),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
