import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_invite.dart';
import 'package:mozin/features/home/presentation/pages/widgets/feature_card.dart';
import 'package:mozin/features/home/presentation/pages/widgets/generate_card.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_cubit.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardInvite(),
        _buildCardHelpMe(),
        SpacerBox.v16,
        _buildPersonalSection(context),
        SpacerBox.v16,
        Center(
          child: BannerAdWidget(
            screenName: Routes.home_partial,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalSection(BuildContext context) {
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
              //_buildCardCalendar(),
              //_buildCardSchedule(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardInvite() {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      bloc: getItInstance<UserInfoCubit>(),
      builder: (context, state) {
        if (state.existCoupleId) {
          return SizedBox.shrink();
        }

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                getItInstance<InviteCubit>().generateShareUrl();
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

  // Widget _buildCardSchedule() {
  //   return AbsorbPointer(
  //     absorbing: true,
  //     child: FeatureCard(
  //       width: SizeConfig.sizeByPixel(100),
  //       iconData: AppIcons.clock,
  //       routeName: Routes.calendar_screen,
  //       name: 'Cronograma',
  //       disabled: true,
  //     ),
  //   );
  // }

  // Widget _buildCardCalendar() {
  //   return AbsorbPointer(
  //     absorbing: true,
  //     child: FeatureCard(
  //       width: SizeConfig.sizeByPixel(100),
  //       iconData: AppIcons.calendar_day,
  //       routeName: Routes.calendar_screen,
  //       name: 'Calendário',
  //       disabled: true,
  //     ),
  //   );
  // }
}
