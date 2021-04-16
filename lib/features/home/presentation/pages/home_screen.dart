import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_invite.dart';
import 'package:mozin/features/home/presentation/pages/widgets/generate_card.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/spacer_box.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserAppModel _user;
  HomeCubit _homeCubit;

  @override
  void initState() {
    _user = getItInstance<UserWrapper>().getUser;
    _homeCubit = getItInstance<HomeCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: BlocBuilder<HomeCubit, HomeState>(
        cubit: _homeCubit,
        builder: (context, state) {
          return _buildContent(state);
        },
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    if (_user == UserAppModel.empty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCardHelpMe(),
          SpacerBox.v16,
          BannerAdWidget(
            screenName: Routes.home_partial,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCardCalendar(),
        SpacerBox.v16,
        _buildCardHelpMe(),
        SpacerBox.v16,
        _buildCardInvite(),
        SpacerBox.v16,
        BannerAdWidget(
            screenName: Routes.home_partial,
        ),
      ],
    );
  }

  Widget _buildCardInvite() {
    return CardInvite();
  }

  Widget _buildCardCalendar() {
    return GenerateCard(
          iconData: AppIcons.calendar_day,
          routeName: Routes.calendar_screen,
          name: 'Calendário',
          description: 'O que pretende fazer nos próximos dias ?',
        );
  }

  Widget _buildCardHelpMe() {
    return GenerateCard(
      iconData: AppIcons.assistive_listening_systems,
      routeName: Routes.feedback_screen,
      name: 'Ajude-nos a melhorar o app',
      description: 'Compartilhe algum problema, sugestão ou melhoria',
    );
  }
}
