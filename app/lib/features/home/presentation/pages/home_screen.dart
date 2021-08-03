import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/home/presentation/blocs/home_cubit/home_cubit.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_invite.dart';
import 'package:mozin/features/home/presentation/pages/widgets/feature_card.dart';
import 'package:mozin/features/home/presentation/pages/widgets/generate_card.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserWrapper _userWrapper;
  HomeCubit _homeCubit;
  InviteCubit _inviteCubit;

  @override
  void initState() {
    _userWrapper = getItInstance<UserWrapper>();
    _homeCubit = getItInstance<HomeCubit>();
    _inviteCubit = getItInstance<InviteCubit>();

    if (_userWrapper.authenticated) {
      _inviteCubit.verifyLoadedUserInternalId();
    }

    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: BlocBuilder<HomeCubit, HomeState>(
          cubit: _homeCubit,
          builder: (context, state) {
            return _buildContent(state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    final bool _autenticated = _userWrapper.authenticated;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardInvite(),
        _buildCardHelpMe(),
        SpacerBox.v16,
        _buildPersonalSection(context, _autenticated),
        SpacerBox.v16,
        _buildAnotherSection(context, _autenticated),
        SpacerBox.v16,
        Center(
          child: BannerAdWidget(
            screenName: Routes.home_partial,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalSection(BuildContext context, bool _autenticated) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Meu".title(context),
        CustomDivider(),
        Container(
          width: SizeConfig.screenWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildCardCalendar(_autenticated),
              _buildCardAlbuns(_autenticated),
              _buildCardFavorites(_autenticated),
              _buildCardSchedule(_autenticated),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnotherSection(BuildContext context, bool _autenticated) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Outros".title(context),
        CustomDivider(),
        Container(
          width: SizeConfig.screenWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildCardSuggestions(),
              _buildCardMusics(),
              _buildCardSites(_autenticated),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardInvite() {
    return BlocBuilder<InviteCubit, InviteState>(
      cubit: _inviteCubit,
      builder: (context, state) {
        if (!state.showCardInvite) {
          return SizedBox.shrink();
        }

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                _inviteCubit.generateShareUrl();
              },
              child: CardContainer(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: CardInvite(
                    isLoading: state.isLoading,
                  ),
                ),
              ),
            ),
            SpacerBox.v16
          ],
        );
      },
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

  Widget _buildCardMusics() {
    return AbsorbPointer(
      absorbing: true,
      child: FeatureCard(
        width: SizeConfig.sizeByPixel(100),
        iconData: AppIcons.music,
        routeName: Routes.calendar_screen,
        name: 'Músicas',
        disabled: true,
      ),
    );
  }

  Widget _buildCardSchedule(bool autenticated) {
    return AbsorbPointer(
      absorbing: true,
      child: FeatureCard(
        width: SizeConfig.sizeByPixel(100),
        iconData: AppIcons.clock,
        routeName: Routes.calendar_screen,
        name: 'Cronograma',
        disabled: true,
      ),
    );
  }

  Widget _buildCardCalendar(bool autenticated) {
    return AbsorbPointer(
      absorbing: !autenticated,
      child: FeatureCard(
        width: SizeConfig.sizeByPixel(100),
        iconData: AppIcons.calendar_day,
        routeName: Routes.calendar_screen,
        name: 'Calendário',
        disabled: !autenticated,
      ),
    );
  }

  Widget _buildCardAlbuns(bool autenticated) {
    return AbsorbPointer(
      absorbing: !autenticated,
      child: FeatureCard(
        width: SizeConfig.sizeByPixel(100),
        iconData: AppIcons.camera_retro,
        routeName: Routes.albums_screen,
        name: 'Álbuns',
        disabled: !autenticated,
      ),
    );
  }

  Widget _buildCardFavorites(bool autenticated) {
    return AbsorbPointer(
      absorbing: !autenticated,
      child: FeatureCard(
        width: SizeConfig.sizeByPixel(100),
        iconData: AppIcons.star,
        routeName: Routes.favorite_interests_screen,
        name: 'Favoritos',
        disabled: !autenticated,
      ),
    );
  }

  Widget _buildCardSuggestions() {
    return FeatureCard(
      width: SizeConfig.sizeByPixel(100),
      iconData: AppIcons.random,
      routeName: Routes.suggestions_screen,
      name: 'Sugestões',
      disabled: false,
    );
  }

  Widget _buildCardSites(bool autenticated) {
    return AbsorbPointer(
      absorbing: true,
      child: FeatureCard(
        width: SizeConfig.sizeByPixel(100),
        iconData: AppIcons.broadcast_tower,
        routeName: Routes.calendar_screen,
        name: 'Sites',
        disabled: true,
      ),
    );
  }
}
