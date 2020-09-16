import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mozin/views/app_view.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => AppView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        _buildItem('Conheça o Enjoy',
            'O app para tirar o casal da rotina e criar experiências incríveis'),
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
