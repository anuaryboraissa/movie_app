import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:movie_app/screens/actor_screen.dart';
import 'package:movie_app/services/models/movie_review/movie_review.dart';
import 'package:movie_app/services/models/single_movie_info/single_movie_info.dart';
import 'package:movie_app/widgets/custom_back_button.dart';
import 'package:movie_app/widgets/film_action_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../constants/app_colors.dart';
import '../services/models/movie.dart';
import '../services/models/single_movie_info/genre.dart';
import '../stm/movie_provider.dart';
import '../widgets/cast_widget.dart';
import '../widgets/film_custom_button.dart';
import '../widgets/film_sliver_background.dart';
import '../widgets/trending_card.dart';

class FilmScreen extends StatefulWidget {
  const FilmScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isSliverAppBarExpanded = false;
  final double _maxScrollExtent = 150.0;

  //page controller
  PageController _pageController = PageController();
  int currentPage = 0;
  static const _kDuration = const Duration(seconds: 1);
  static const _kCurve = Curves.ease;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Provider.of<MovieProvider>(context, listen: false).getDetailedMovieInfo(
        dotenv.env['TMDB_API_KEY'].toString(), widget.movie.id.toString());
    Provider.of<MovieProvider>(context, listen: false).getSimilarMovies(
        dotenv.env['TMDB_API_KEY'].toString(), widget.movie.id.toString());
    Provider.of<MovieProvider>(context, listen: false).getCastCrew(
        dotenv.env['TMDB_API_KEY'].toString(), widget.movie.id.toString());
    Provider.of<MovieProvider>(context, listen: false).getMovieReviews(
        dotenv.env['TMDB_API_KEY'].toString(), widget.movie.id.toString());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Listen to scroll position and check whether the SliverAppBar is collapsed
    if (_scrollController.hasClients) {
      if (_scrollController.offset > _maxScrollExtent) {
        setState(() {
          _isSliverAppBarExpanded = true;
        });
      } else {
        setState(() {
          _isSliverAppBarExpanded = false;
        });
      }
    }
  }

  List<Widget> widgets = [];
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<MovieProvider>(builder: (context, provider, _) {
      if (provider.detailedMovieInfo != null &&
          provider.detailedMovieInfo!["success"] &&
          !isLoaded) {
        // Convert the items to a list of widgets with icons between them
        List<Genre>? allGens =
            (((provider.detailedMovieInfo!["info"] as SingleMovieInfo)
                .genres)!);
        List<Genre>? allGensUpdate =
            (allGens.length > 3 ? allGens.sublist(0, 3) : allGens);
        for (int i = 0; i < allGensUpdate.length; i++) {
          Genre gen = allGensUpdate[i];
          widgets.add(
            Text(
              "${gen.name}",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                // color: ApplicationColors.f8f8,
              ),
            ),
          );

          // Add Icon between items, but not after the last item
          if (i < allGensUpdate.length - 1) {
            widgets.add(Row(
              children: const [
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ));
            debugPrint("Add widget =======> ");
          }
        }
        isLoaded = true;
      }
      return Scaffold(
        body: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: provider.similarMovies == null ||
                  provider.detailedMovieInfo == null ||
                  provider.castCrew == null ||
                  provider.movieReviews == null ||
                  provider.similarMovies == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : !provider.similarMovies!["success"]
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.getSimilarMovies(
                                  dotenv.env['TMDB_API_KEY'].toString(),
                                  widget.movie.id.toString());
                              provider.getDetailedMovieInfo(
                                  dotenv.env['TMDB_API_KEY'].toString(),
                                  widget.movie.id.toString());
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
                          Text(provider.similarMovies!["message"],
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverAppBar(
                              leading: const CustomBackButton(),
                              automaticallyImplyLeading: false,
                              expandedHeight: 210.h,
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              pinned: true,
                              leadingWidth: kToolbarHeight,
                              toolbarHeight: kToolbarHeight,
                              centerTitle: true,
                              titleTextStyle: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: ApplicationUtils.getTheme(context)
                                    .colorScheme
                                    .onBackground,
                              ),
                              title: _isSliverAppBarExpanded
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6.h),
                                      child: Text(
                                          widget.movie.originalTitle.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ApplicationUtils.getTheme(
                                                    context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    )
                                  : const SizedBox.shrink(),
                              flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.parallax,
                                titlePadding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                // background: SliverBackground(
                                //     isSliverAppBarExpanded: _isSliverAppBarExpanded,
                                //     size: size),
                                background: SizedBox(
                                  width: size.width,
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
                                          return FilmSliverBackground(
                                              reviewsNumber:
                                                  (provider.movieReviews![
                                                          "reviews"] as List)
                                                      .length,
                                              releaseYear:
                                                  (provider.detailedMovieInfo![
                                                              "info"]
                                                          as SingleMovieInfo)
                                                      .releaseDate!
                                                      .split("-")
                                                      .first,
                                              rating: double.parse(widget
                                                  .movie.voteAverage!
                                                  .toStringAsFixed(1)),
                                              isSliverAppBarExpanded:
                                                  _isSliverAppBarExpanded,
                                              size: size);
                                        },
                                      ),
                                      Positioned(
                                        bottom: 55,
                                        right: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 130,
                                          child: DotsIndicator(
                                            dotsCount: 6,
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
                                                          BorderRadius.circular(
                                                              5.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom:
                                            -4, // Position button at the bottom
                                        left: 0,
                                        right: 0,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: size.width,
                                              margin:
                                                  const EdgeInsets.only(top: 1),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: ApplicationUtils
                                                          .isDarkTheme(context)
                                                      ? Colors.transparent
                                                          .withOpacity(.6)
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  45),
                                                          topRight:
                                                              Radius.circular(
                                                                  45))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: FilmCustomButton(
                                                size: Size(size.width,
                                                    20), // Set button size
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                centerTitle: true,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: widgets,
                                          ),
                                          Text(
                                            ApplicationUtils.convertMinutesToHM(
                                                (provider.detailedMovieInfo![
                                                            "info"]
                                                        as SingleMovieInfo)
                                                    .runtime!
                                                    .toInt()),
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
                                        "${widget.movie.originalTitle}",
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
                                        "${widget.movie.overview}",
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
                                      FilmActionWidget(size: size),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Cast & Crew",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          const ActorScreen()));
                                            },
                                            child: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: 200,
                                          child: (provider.castCrew!["castCrew"]
                                                      as List)
                                                  .isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "Nothing Found!",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // color: ApplicationColors.f8f8,
                                                    ),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: (provider
                                                              .castCrew![
                                                          "castCrew"] as List)
                                                      .length,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      CastWidget(
                                                          size: size,
                                                          castCrew: (provider
                                                                      .castCrew![
                                                                  "castCrew"]
                                                              as List)[index]),
                                                )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text.rich(TextSpan(
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            // color: ApplicationColors.f8f8,
                                          ),
                                          text: "Audio Track: ",
                                          children: [
                                            TextSpan(
                                              text:
                                                  (provider.detailedMovieInfo![
                                                              "info"]
                                                          as SingleMovieInfo)
                                                      .spokenLanguages!
                                                      .map((e) => e.name)
                                                      .toList()
                                                      .join(","),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary),
                                            )
                                          ])),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text.rich(TextSpan(
                                          text: "Subtitles: ",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            // color: ApplicationColors.f8f8,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  (provider.detailedMovieInfo![
                                                              "info"]
                                                          as SingleMovieInfo)
                                                      .spokenLanguages!
                                                      .map((e) => e.name)
                                                      .toList()
                                                      .join(","),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary),
                                            )
                                          ])),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Reviews",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "All Reviews",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: ApplicationColors.baoa,
                                                ),
                                              ))
                                        ],
                                      ),
                                      if ((provider.movieReviews!["reviews"]
                                              as List)
                                          .isNotEmpty)
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${(provider.movieReviews!["reviews"] as List<MovieReview>).first.authorDetails!.username}",
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
                                                  ApplicationUtils.convertDateFormat(
                                                      (provider.movieReviews![
                                                                  "reviews"]
                                                              as List<
                                                                  MovieReview>)
                                                          .first
                                                          .createdAt
                                                          .toString()),
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    // color: ApplicationColors.f8f8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            ReadMoreText(
                                              (provider.movieReviews!["reviews"]
                                                      as List<MovieReview>)
                                                  .first
                                                  .content
                                                  .toString(),
                                              trimMode: TrimMode.Line,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
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
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                SizedBox(
                                                  width: size.width * .02,
                                                ),
                                                Text(
                                                  "${(provider.movieReviews!["reviews"] as List<MovieReview>).first.authorDetails!.rating}/10",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      else
                                        Text(
                                          "No Reviews yet",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("More like this",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                          height: 180,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (provider.similarMovies![
                                                    "movies"] as List)
                                                .length,
                                            itemBuilder: (context, index) =>
                                                TrendingNowCard(
                                                    size: size,
                                                    movie: (provider
                                                                .similarMovies![
                                                            "movies"]
                                                        as List<Movie>)[index]),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
        ),
      );
    });
  }
}
