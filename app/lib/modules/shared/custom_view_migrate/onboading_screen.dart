import 'package:custom_view/custom_font_size.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    root<AuthenticationBloc>().add(CloseOnboardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        _buildItem('Conheça o Enjoy',
            'O app para deixar a rotina do casal mais interessante'),
        _buildItem('Pesquise o que fazer',
            'A partir de alguns filtros, descubra lugares ou coisas para fazer em casa'),
        _buildItem(
            'Linha do tempo', 'Monte uma linha do tempo privada contendo fotos de vocês'),
        _buildItem('Calendário de compromissos',
            'Agende o que fazer para hoje e os próximos dias'),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        'Pular',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).backgroundColor,
            fontSize: CustomFontSize.f18),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).backgroundColor,
        size: CustomFontSize.f22,
      ),
      done: Text(
        'Continuar',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).backgroundColor,
          fontSize: CustomFontSize.f18,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).backgroundColor,
        activeSize: Size(22.0, 10.0),
        activeColor: Theme.of(context).accentIconTheme.color,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  PageViewModel _buildItem(String title, String message) {
    TextStyle bodyStyle = TextStyle(
      fontSize: CustomFontSize.f22,
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
        height: MediaQuery.of(context).size.height / 4,
      ),
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/images/logo_white.png"),
          ),
          SpacerBox.v50,
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
