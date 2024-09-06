import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/app_utils.dart';
import 'package:movie_app/screens/actor_screen.dart';
import 'package:movie_app/widgets/custom_back_button.dart';
import 'package:movie_app/widgets/film_action_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';

import '../constants/app_colors.dart';
import '../widgets/cast_widget.dart';
import '../widgets/film_custom_button.dart';
import '../widgets/film_sliver_background.dart';
import '../widgets/trending_card.dart';

class FilmScreen extends StatefulWidget {
  const FilmScreen({super.key});

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
        ),
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  leading: const CustomBackButton(),
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
                              return FilmSliverBackground(
                                  rating: 7.6,
                                  isSliverAppBarExpanded:
                                      _isSliverAppBarExpanded,
                                  size: size);
                            },
                          ),
                          Positioned(
                            bottom: 42,
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
                            bottom: -1, // Position button at the bottom
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: FilmCustomButton(
                                size: Size(size.width, 20), // Set button size
                              ),
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
                                  Text(
                                    "Adventure",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      // color: ApplicationColors.f8f8,
                                    ),
                                  ),
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
                                "3h 12m",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // color: ApplicationColors.f8f8,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 2,
                          ),
                          ReadMoreText(
                            "The film stars Sam Worthington as Jake Sully, a disabled Marine who has been sent to Pandora to assist Earth's Resources Development Administration (RDA) in its search for an exotic substance called “unobtanium.” Because Pandora's atmosphere is toxic to humans, and because the planet is inhabited by a large humanoid,a disabled Marine who has been sent to Pandora to assist Earth's Resources Development Administration (RDA) in its search for an exotic substance called “unobtanium.” Because Pandora's atmosphere is toxic to humans, and because the planet is inhabited by a large humanoid",
                            trimMode: TrimMode.Line,
                            trimLines: 6,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ApplicationColors.e00,
                            ),
                            lessStyle: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ApplicationColors.e00,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FilmActionWidget(size: size),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          type: PageTransitionType.rightToLeft,
                                          child: const ActorScreen()));
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: size.height * .23,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) =>
                                    CastWidget(size: size),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(TextSpan(
                            style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ),
                            text: "Audio Track: ", children: [
                            TextSpan(text: "English,Polish,German,Spanish",
                            style: GoogleFonts.montserrat(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ),
                            )
                          ])),
                          SizedBox(
                            height: 4,
                          ),
                          Text.rich(TextSpan(text: "Subtitles: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ), children: [
                            TextSpan(text: "English,Polish,Germany",
                            style: GoogleFonts.montserrat(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ),
                            )
                          ])),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Reviews",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextButton(
                                  onPressed: () {},
                                  child:  Text("All Reviews",style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: ApplicationColors.f8f8,
                          ),))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Paragon240",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // color: ApplicationColors.f8f8,
                                ),
                              ),
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
                              Text(
                                "14.08.23",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // color: ApplicationColors.f8f8,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Visually stunning and actions packed but story is light",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              // color: ApplicationColors.f8f8,
                            ),
                          ),
                          SizedBox(
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
                                "6/10",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                              height: size.height * .23,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) =>
                                    TrendingNowCard(size: size),
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
  }
}
