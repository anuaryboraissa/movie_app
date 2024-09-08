import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:movie_app/services/models/actor_philmography.dart';
import 'package:movie_app/services/models/person_image.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../constants/app_colors.dart';
import '../services/models/actor_detail.dart';
import '../services/models/cast_crew.dart';
import '../stm/movie_provider.dart';
import '../widgets/actor_top_background.dart';
import '../widgets/filmography_card.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({super.key, required this.castCrew});
  final CastCrew castCrew;

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getActorFilmography(
        dotenv.env['TMDB_API_KEY'].toString(), widget.castCrew.id.toString());
    Provider.of<MovieProvider>(context, listen: false).getActorDetails(
        dotenv.env['TMDB_API_KEY'].toString(), widget.castCrew.id.toString());
    Provider.of<MovieProvider>(context, listen: false).getActorImages(
        dotenv.env['TMDB_API_KEY'].toString(), widget.castCrew.id.toString());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<MovieProvider>(builder: (context, provider, _) {
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
          child: provider.actorFilmography == null ||
                  provider.actorImages == null ||
                  provider.singleActorDetails == null
              ?  const Center(
                  child: NutsActivityIndicator(
                        activeColor: ApplicationColors.e00,
                        inactiveColor: ApplicationColors.e7e7,
                        tickCount: 24,
                        relativeWidth: 0.4,
                        radius: 15,
                        startRatio: 0.7,
                        animationDuration: Duration(milliseconds: 500),
                      ),
                )
              : !provider.similarMovies!["success"]
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.getActorFilmography(
                                  dotenv.env['TMDB_API_KEY'].toString(),
                                  widget.castCrew.id.toString());
                              provider.getActorDetails(
                                  dotenv.env['TMDB_API_KEY'].toString(),
                                  widget.castCrew.id.toString());
                              provider.getActorImages(
                                  dotenv.env['TMDB_API_KEY'].toString(),
                                  widget.castCrew.id.toString());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.sync),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Reload",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(provider.actorFilmography!["message"],
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    )
                  : Stack(
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
                                      itemCount: (provider.actorImages![
                                                          "profiles"]
                                                      as List<PersonImage>)
                                                  .length >
                                              6
                                          ? 6
                                          : (provider.actorImages!["profiles"]
                                                  as List<PersonImage>)
                                              .length,
                                      controller: _pageController,
                                      onPageChanged: (value) {
                                        currentPage = value;
                                        setState(() {});
                                      },
                                      itemBuilder: (context, index) {
                                        return ActorTopBackground(
                                            image: (provider
                                                    .actorImages!["profiles"]
                                                as List<PersonImage>)[index],
                                            size: size);
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
                                                color: ApplicationColors.a26
                                                    .withOpacity(.8),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Center(
                                                    child: Icon(
                                                  Icons
                                                      .arrow_back_ios_new_rounded,
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            DotsIndicator(
                                              dotsCount: (provider.actorImages![
                                                                  "profiles"]
                                                              as List<
                                                                  PersonImage>)
                                                          .length >
                                                      6
                                                  ? 6
                                                  : (provider.actorImages![
                                                              "profiles"]
                                                          as List<PersonImage>)
                                                      .length,
                                              position: currentPage,
                                              decorator: DotsDecorator(
                                                color: ApplicationColors.baoa,
                                                activeColor:
                                                    ApplicationColors.f8f8,
                                                size: const Size.square(9.0),
                                                // activeSize: Size(18.0, 9.0),
                                                activeShape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 4,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        // color: Colors.black.withOpacity(0.5), // Optional background color
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120.w,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: ApplicationColors.d30
                                                    .withOpacity(.8),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text.rich(TextSpan(
                                                    text:
                                                        "Top ${(provider.singleActorDetails!["actor"] as ActorDetail).popularity!.round()} ",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ApplicationColors
                                                          .f8f8,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: "IMDb",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              ApplicationColors
                                                                  .baoa,
                                                        ),
                                                      )
                                                    ])),
                                              ),
                                            ),
                                          ],
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Actor",
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
                                            "Stunts",
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
                                            "Producer",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              // color: ApplicationColors.f8f8,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        DateFormat('MMMM d, y').format(
                                            DateTime.parse(
                                                (provider.singleActorDetails![
                                                        "actor"] as ActorDetail)
                                                    .birthday
                                                    .toString())),
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
                                    (provider.singleActorDetails!["actor"]
                                            as ActorDetail)
                                        .name
                                        .toString(),
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
                                    (provider.singleActorDetails!["actor"]
                                            as ActorDetail)
                                        .biography
                                        .toString(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        itemCount: (provider.actorFilmography![
                                                        "movies"] as List)
                                                    .length >
                                                10
                                            ? 10
                                            : (provider.actorFilmography![
                                                    "movies"] as List)
                                                .length,
                                        itemBuilder: (context, index) =>
                                            FilmographyCard(
                                                size: size,
                                                philmography: (provider
                                                                .actorFilmography![
                                                            "movies"]
                                                        as List<
                                                            ActorPhilmography>)[
                                                    index]),
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
                                          text: ApplicationUtils.extractCityAndCountry((provider.singleActorDetails!["actor"]
                                            as ActorDetail).placeOfBirth.toString())["city"],
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
                                          text:  ApplicationUtils.extractCityAndCountry((provider.singleActorDetails!["actor"]
                                            as ActorDetail).placeOfBirth.toString())["country"],
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
    });
  }
}
