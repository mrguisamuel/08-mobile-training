import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class OnboardPage extends StatelessWidget {
  BuildContext context;
  final Color color;
  final String urlImage, title, subtitle;

  OnboardPage({
    required this.context,
    required this.color,
    required this.urlImage,
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(this.context).size.width
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
            )
          )
        )
      ]
    );
  }
}

class _OnboardingState extends State<Onboarding> {
  final _pageController = PageController(initialPage: 0);

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
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  OnboardPage(
                    context: context,
                    color: Colors.green,
                    urlImage: 'assets/images/onboarding-1.jpg',
                    title: 'Teste',
                    subtitle: 'Teste2'
                  ),
                  OnboardPage(
                    context: context,
                    color: Colors.green,
                    urlImage: 'assets/images/onboarding-2.jpg',
                    title: 'Teste3',
                    subtitle: 'Teste4'
                  ),
                  OnboardPage(
                    context: context,
                    color: Colors.green,
                    urlImage: 'assets/images/onboarding-3.jpg',
                    title: 'Teste5',
                    subtitle: 'Teste6'
                  ),
                ]
              )
            ),
            ElevatedButton(
              onPressed: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder()
              ),
              child: Icon(
                Icons.navigate_next,
                color: Colors.white
              )
            )
          ]
        )
      )
    );
  }
}