import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';

import '../../widgets/widgets_export.dart';

class OnBoardingScreen extends StatelessWidget {
  int index = 0;
  double value = 0;
  List<Widget> images = [
    templateBoarding(
      imagePath: "assets/on_boarding_images/on_boarding_first.png",
      heading: "Welcome to Stay Finder",
      body:
          "Get ready to find your perfect stay for internships, jobs, or studies away from home. Start by creating your profile.",
    ),
    templateBoarding(
      imagePath: "assets/on_boarding_images/on_boarding_second.png",
      heading: "Add Yours too",
      body: """Empower your journey with our map-based
 platform.  Select rooms and hostels near your
 office or college, all within your preferred budget""",
    ),
    templateBoarding(
      imagePath: "assets/on_boarding_images/on_boarding_third.png",
      heading: "Make Money",
      body: """
Grow your business with additional
 listings through our monthly subscription.""",
    ),
  ];
  CarouselController buttonCarsouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: TextButton(
            onPressed: () {
              if (this.index == 2) {
                Navigator.pushNamed(context, "/main");
              } else {
                buttonCarsouselController.nextPage();
                context.read<OnBoardingBloc>()..add(ChangeEvent());
              }
            },
            child: Text("Next", style: TextStyle(color: Color(0xff29383F)))),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.read<OnBoardingBloc>()..add(ChangeEvent());
                          Navigator.pushNamed(context, "/main");
                        },
                        child: Hero(tag: "here", child: Text("Skip")))
                  ],
                ),
              ),
              FlutterCarousel(
                items: images,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    this.index = index;
                  },
                  onScrolled: (value) {
                    // this.index = value.;
                    this.value = value!;
                  },
                  autoPlay: false,
                  controller: buttonCarsouselController,
                  height: MediaQuery.of(context).size.height / 1.4,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  showIndicator: false,
                  initialPage: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class templateBoarding extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String body;
  const templateBoarding({
    super.key,
    required this.imagePath,
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(imagePath),
          SizedBox(
            height: 20,
          ),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff29383F),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            body,
            style: TextStyle(color: Color(0xff808080), fontSize: 12),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
