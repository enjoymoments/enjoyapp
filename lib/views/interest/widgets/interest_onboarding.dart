import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mozin/views/interest/widgets/interest_categories.dart';
import 'package:mozin/views/search_places/search_places_screen.dart';

class InterestOnBoarding extends StatefulWidget {
  @override
  _InterestOnBoardingState createState() => _InterestOnBoardingState();
}

class _InterestOnBoardingState extends State<InterestOnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SearchPlacesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        _selectCategory(),
        _selectItemsByCategory(),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Pular',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).primaryColor,
      ),
      done: Text(
        'Continuar',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).primaryColor,
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xFFFCBA03),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  PageViewModel _selectCategory() {
    return PageViewModel(
      titleWidget: SizedBox.shrink(),
      bodyWidget: InterestCategories(),
    );
  }

  PageViewModel _selectItemsByCategory() {
    return PageViewModel(
      titleWidget: SizedBox.shrink(),
      bodyWidget: InterestCategories(),
    );
  }
}
