import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatelessWidget {
  PageController controller;
  HomeSlider({Key? key, required this.controller}) : super(key: key);
  var images = [
    'images/a1.png',
    'images/a2.png',
    'images/a3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          allowImplicitScrolling: true,
          controller: controller,
          children: images.map((element) {
            return buildImageSlide(element);
          }).toList(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: buildDotIndicator(context),
        )
      ],
    );
  }

  Widget buildDotIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: ExpandingDotsEffect(
          dotWidth: 8,
          dotHeight: 8,
          dotColor: Colors.grey,
          activeDotColor: Theme.of(context).primaryColor,
          expansionFactor: 2,
        ),
        onDotClicked: (pageIndex) {
          controller.animateToPage(pageIndex,
              duration: const Duration(microseconds: 300),
              curve: Curves.easeInOut);
        },
      ),
    );
  }

  Widget buildImageSlide(String imagePath) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      child: Image(
        image: AssetImage(imagePath),
        fit: BoxFit.fill,
      ),
    );
  }
}
