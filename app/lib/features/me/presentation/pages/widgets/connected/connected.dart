import 'package:auto_route/auto_route.dart';
import 'package:custom_view/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/ads/presentation/pages/banners/banner_ad_widget.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_invite.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/features/me/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/general/services/launch_url_service.dart';
import 'package:mozin/modules/shared/general/services/stores_service.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:custom_view/custom_tile.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_cubit.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_state.dart';

class Connected extends StatelessWidget {
  final UserAppModel? user;

  const Connected({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: <Widget>[
            SpacerBox.v10,
            _buildHeader(context),
            SpacerBox.v30,
            _buildCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CustomAvatar(
          radius: SizeConfig.sizeByPixel(25),
        ),
        SpacerBox.h16,
        if(user!.name != null) user!.name!.title(context) else SizedBox.shrink(),
      ],
    );
  }

  Widget _buildCards(BuildContext context) {
    return Column(
      children: [
        _buildCardInvite(),
        _buildNotifications(context),
        ..._divider(),
        //TODO:in development
        // _buildAlbums(context),
        // ..._divider(),
        _buildFeedback(context),
        ..._divider(),
        _buildMoreAboutUs(context),
        ..._divider(),
        _buildOpenStores(context),
        ..._divider(),
        _buildUnsyncCouple(),
        BannerAdWidget(
          screenName: Me_authenticated_partial.name,
        ),
        ..._buildLogout(),
        SpacerBox.v26,
      ],
    );
  }

  Widget _buildFeedback(BuildContext context) {
    return CustomTile(
      title: 'Ajude-nos a melhorar o app',
      description: 'Compartilhe algum problema, sugestão ou melhoria',
      iconStart: AppIcons.assistive_listening_systems,
      iconEnd: AppIcons.angle_right,
      onTap: () {
        AutoRouter.of(context).push(Feedback_screen());
      },
    );
  }

  Widget _buildNotifications(BuildContext context) {
    return CustomTile(
      title: 'Notificações',
      description: 'Minha central de notificações',
      iconStart: AppIcons.bell,
      iconEnd: AppIcons.angle_right,
      onTap: () {
        AutoRouter.of(context).push(Notification_screen());
      },
    );
  }

  Widget _buildAlbums(BuildContext context) {
    return CustomTile(
      title: 'Álbums',
      description: 'Veja aqui os seus álbuns',
      iconStart: AppIcons.camera_retro,
      iconEnd: AppIcons.angle_right,
      onTap: () {
        AutoRouter.of(context).push(Albums_screen());
      },
    );
  }

  Widget _buildOpenStores(BuildContext context) {
    return CustomTile(
      title: 'Curtiu o Enjoy? Avalie-nos',
      description: 'Dá aquela 5 estrelas pra gente ;)',
      iconStart: AppIcons.thumbs_up,
      iconEnd: AppIcons.angle_right,
      onTap: () {
        StoresService.redirectToStore(() {
          context.showSnackBar('Ops... em breve nas lojas');
        });
      },
    );
  }

  Widget _buildMoreAboutUs(BuildContext context) {
    return CustomTile(
      title: 'Mais sobre nós',
      description: 'Redes sociais',
      iconStart: AppIcons.info_circle,
      iconEnd: AppIcons.angle_right,
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => CustomModalFit(
            items: [
              CustomItemModalFit(
                text: 'Instagram',
                iconData: AppIcons.instagram,
                onTap: () {
                  LaunchUrlService.launchURL(
                      'https://www.instagram.com/myenjoymoments/');
                },
              ),
              CustomItemModalFit(
                text: 'Facebook',
                iconData: AppIcons.facebook,
                onTap: () {
                  LaunchUrlService.launchURL(
                      'https://www.facebook.com/Enjoy-108714310939674');
                },
              ),
              CustomItemModalFit(
                text: 'Linkedin',
                iconData: AppIcons.linkedin,
                onTap: () {
                  LaunchUrlService.launchURL(
                      'https://www.linkedin.com/company/enjoy-moments/');
                },
              ),
              CustomItemModalFit(
                text: 'Site',
                iconData: AppIcons.window_maximize,
                onTap: () {
                  LaunchUrlService.launchURL('https://enjoymoments.com.br');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _divider() {
    return [
      SpacerBox.v14,
      CustomDivider(),
      SpacerBox.v14,
    ];
  }

  List<Widget> _buildLogout() {
    if (!_notAuthenticated()) {
      return [
        ..._divider(),
        CustomTile(
          title: 'Sair',
          description: 'Vou logo ali e já volto',
          iconStart: AppIcons.window_close,
          iconEnd: AppIcons.angle_right,
          onTap: () {
            root<AuthenticationBloc>()..add(Logout());
          },
        ),
      ];
    }

    return [];
  }

  bool _notAuthenticated() {
    if (getItInstance.isRegistered<UserWrapper>() &&
        (getItInstance<UserWrapper>().getUser == UserAppModel.empty())) {
      return true;
    }

    return false;
  }

  Widget _buildCardInvite() {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      bloc: getItInstance<UserInfoCubit>(),
      builder: (context, state) {
        if (state.existCoupleId!) {
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
            SpacerBox.v16,
            ..._divider(),
          ],
        );
      },
    );
  }

  Widget _buildUnsyncCouple() {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      bloc: getItInstance<UserInfoCubit>(),
      builder: (context, state) {
        if (state.existCoupleId!) {
          return Column(
            children: [
              CustomTile(
                title: 'Desvincular com o meu par',
                description: 'Cansei, não quero mais',
                iconStart: AppIcons.undo,
                iconEnd: AppIcons.angle_right,
                onTap: () {
                  AutoRouter.of(context)
                      .push(Unsync_couple_screen());
                },
              ),
              ..._divider(),
            ],
          );
        }

        if (state.isLoading!) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                width: SizeConfig.sizeByPixel(SizeConfig.screenWidth!),
                height: SizeConfig.sizeByPixel(40),
              ),
              ..._divider(),
            ],
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
