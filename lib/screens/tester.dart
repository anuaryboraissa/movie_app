import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:movie_app/screens/film_screen.dart';
import 'package:movie_app/services/models/genre.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/sliver_background.dart';
import 'package:movie_app/widgets/trending_card.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../services/models/movie.dart';
import '../stm/movie_provider.dart';
import '../widgets/custom_button.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
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
    Provider.of<MovieProvider>(context, listen: false).getCurrentlyPlayedMovies(
        dotenv.env['API_READ_ACCESS_TOKEN'].toString());
    Provider.of<MovieProvider>(context, listen: false)
        .getPopularMovies(dotenv.env['API_READ_ACCESS_TOKEN'].toString());
    Provider.of<MovieProvider>(context, listen: false)
        .getTrendingMovies(dotenv.env['API_READ_ACCESS_TOKEN'].toString());
    Provider.of<MovieProvider>(context, listen: false)
        .getMovieGenres(dotenv.env['API_READ_ACCESS_TOKEN'].toString());
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<MovieProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: provider.playedMovieData == null ||
                  provider.popularMovieData == null ||
                  provider.trendingMovieData == null ||
                  provider.movieGenres == null
              ? const Center(
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
              : !provider.playedMovieData!["success"]
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.getCurrentlyPlayedMovies(dotenv
                                  .env['API_READ_ACCESS_TOKEN']
                                  .toString());
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
                          Text(provider.playedMovieData!["message"],
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
                                      child: Text("Home",
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
                                        itemCount: (provider.popularMovieData![
                                                            "movies"]
                                                        as List<Movie>)
                                                    .length >
                                                6
                                            ? 6
                                            : (provider.popularMovieData![
                                                    "movies"] as List<Movie>)
                                                .length,
                                        controller: _pageController,
                                        onPageChanged: (value) {
                                          currentPage = value;
                                          setState(() {});
                                        },
                                        itemBuilder: (context, index) {
                                          Movie movie = (provider
                                                  .popularMovieData!["movies"]
                                              as List<Movie>)[index];
                                          print("Genre Ids: ${movie.genreIds}");
                                          // List<Genre> movieGenres = movie
                                          //     .genreIds!
                                          //     .map((genreId) =>
                                          //         (provider.movieGenres![
                                          //                     "genres"]
                                          //                 as List<Genre>)
                                          //             .where((gen) {
                                          //           debugPrint(
                                          //               "Check this: ${gen.id} and $genreId =========> ");
                                          //           return gen.id == genreId;
                                          //         }).first)
                                          //     .toList();
                                          List<Genre> matchedGenres = movie
                                              .genreIds!
                                              .map((id) => (provider
                                                          .movieGenres![
                                                      "genres"] as List<Genre>)
                                                  .firstWhere((genre) =>
                                                      genre.id == id))
                                              .toList();

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: FilmScreen(
                                                        movie: movie,
                                                      )));
                                            },
                                            child: SliverBackground(
                                                movie: movie,
                                                genres: matchedGenres,
                                                isSliverAppBarExpanded:
                                                    _isSliverAppBarExpanded,
                                                size: size),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        bottom: 50,
                                        right: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 130,
                                          child: Row(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              DotsIndicator(
                                                dotsCount:
                                                    (provider.popularMovieData![
                                                                        "movies"]
                                                                    as List<Movie>)
                                                                .length >
                                                            6
                                                        ? 6
                                                        : (provider.popularMovieData![
                                                                    "movies"]
                                                                as List<Movie>)
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
                                                              BorderRadius.circular(
                                                                  5.0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //     bottom:
                                      //         0, // Position button at the bottom
                                      //     left: 0,
                                      //     right: 0,
                                      //     child: ),
                                      Positioned(
                                        bottom:
                                            -3, // Position button at the bottom
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
                                                          .withOpacity(.8)
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
                                                      horizontal: 1.0),
                                              child: CustomButton(
                                                size: Size(size.width,
                                                    20), // Set button size
                                              ),
                                            )
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
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      right: 10,
                                      left: 10,
                                      bottom: 60),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Continue Watching",
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
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 180,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (provider
                                                        .playedMovieData![
                                                    "movies"] as List<Movie>)
                                                .length,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child: FilmScreen(
                                                          movie: (provider
                                                                      .playedMovieData![
                                                                  "movies"]
                                                              as List<
                                                                  Movie>)[index],
                                                        )));
                                              },
                                              child: Moviecard(
                                                size: size,
                                                movie:
                                                    (provider.playedMovieData![
                                                            "movies"]
                                                        as List<Movie>)[index],
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Trending Now",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     PageTransition(
                                              //         type: PageTransitionType
                                              //             .rightToLeft,
                                              //         child:
                                              //             const FilmScreen()));
                                            },
                                            child: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 180,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (provider
                                                        .playedMovieData![
                                                    "movies"] as List<Movie>)
                                                .length,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child: FilmScreen(
                                                          movie: (provider
                                                                      .playedMovieData![
                                                                  "movies"]
                                                              as List<
                                                                  Movie>)[index],
                                                        )));
                                              },
                                              child: TrendingNowCard(
                                                size: size,
                                                movie:
                                                    (provider.playedMovieData![
                                                            "movies"]
                                                        as List<Movie>)[index],
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Popular Now",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     PageTransition(
                                              //         type: PageTransitionType
                                              //             .rightToLeft,
                                              //         child:
                                              //             const FilmScreen()));
                                            },
                                            child: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                          height: 180,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (provider
                                                        .trendingMovieData![
                                                    "movies"] as List<Movie>)
                                                .length,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child: FilmScreen(
                                                          movie: (provider
                                                                      .trendingMovieData![
                                                                  "movies"]
                                                              as List<
                                                                  Movie>)[index],
                                                        )));
                                              },
                                              child: TrendingNowCard(
                                                  size: size,
                                                  movie: (provider
                                                              .trendingMovieData![
                                                          "movies"]
                                                      as List<Movie>)[index]),
                                            ),
                                          )),
                                      // Languages(languages: ["swahili","English"]),
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
