import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mozin/modules/config/router.gr.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    ExtendedNavigator.of(context).pushAndRemoveUntil(Routes.screen_manager, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        _buildItem('Conheça o Mozin',
            'O app para tirar o casal da rotina e criar experiênias incriveis'),
        _buildItem('Compartilhe fotos',
            'Construa uma linha do tempo contendo todas as suas memórias'),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Pular',
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).backgroundColor,
      ),
      done: Text(
        'Continuar',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).backgroundColor),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).backgroundColor,
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xFFFCBA03),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  PageViewModel _buildItem(String title, String message) {
    TextStyle bodyStyle = TextStyle(
      fontSize: 19.0,
      color: Theme.of(context).backgroundColor,
    );
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).backgroundColor,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).primaryColor,
      imagePadding: EdgeInsets.zero,
    );

    return PageViewModel(
      titleWidget: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
      ),
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: pageDecoration.titleTextStyle,
          ),
          Text(message, textAlign: TextAlign.center, style: bodyStyle),
        ],
      ),
      decoration: pageDecoration,
    );
  }
}