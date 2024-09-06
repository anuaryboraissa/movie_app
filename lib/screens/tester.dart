import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_colors.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:movie_app/screens/film_screen.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/sliver_background.dart';
import 'package:movie_app/widgets/trending_card.dart';
import 'package:page_transition/page_transition.dart';

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
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          // systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 210.h,
                  backgroundColor: Theme.of(context).colorScheme.background,
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
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Text("Doctor Strange",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: ApplicationUtils.getTheme(context)
                                    .colorScheme
                                    .onBackground,
                              )),
                        )
                      : const SizedBox.shrink(),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    titlePadding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                              return SliverBackground(
                                  isSliverAppBarExpanded:
                                      _isSliverAppBarExpanded,
                                  size: size);
                            },
                          ),
                          Positioned(
                            bottom: 40,
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
                          Positioned(
                              bottom: 0, // Position button at the bottom
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: CustomButton(
                                  size: Size(size.width, 20), // Set button size
                                ),
                              ))
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Continue Watching",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const FilmScreen()));
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
                              height: size.height * .23,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) =>
                                    Moviecard(size: size),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Trending Now",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const FilmScreen()));
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
                              height: size.height * .23,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) =>
                                    TrendingNowCard(size: size),
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
  }
}
