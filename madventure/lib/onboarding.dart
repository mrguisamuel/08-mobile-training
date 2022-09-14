import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class OnboardPages {
  BuildContext context;
  final Color color;
  final String urlImage, title, subtitle;

  OnboardPages({
    required this.context,
    required this.color,
    required this.urlImage,
    required this.title,
    required this.subtitle
  }) => build();

  Widget build() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(this.context).size.width
        ),
        Text(
          title
        )
      ]
    );
  }
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: PageView(
            children: <Widget>[
              buildPage(
                context: context,
                urlImage: 'assets/images/onboarding-1.jpg',
                color: Colors.green,
                title: 'Teste1',
                subtitle: 'opa'
              )
            ]
          )
        )
      )
    );
  }
}