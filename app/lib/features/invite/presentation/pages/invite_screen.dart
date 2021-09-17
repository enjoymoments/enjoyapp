import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/features/invite/presentation/pages/widgets/invite_screen_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:custom_view/custom_button_default.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/custom_gif.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/custom_tile.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({
    Key key,
    @required this.inviteCubit,
  }) : super(key: key);

  final InviteCubit inviteCubit;

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }  

  void _redirectSuccessScreen(BuildContext context) {
    ExtendedNavigator.of(context).popAndPush(
      Routes.success_screen,
      arguments: CustomSuccessScreenArguments(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            'YEEAAAHHHH\nNovo casal na área !!!'.labelIntro(context),
            SpacerBox.v24,
            CustomGif(path: 'assets/images/party.webp'),
          ],
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return BlocConsumer<InviteCubit, InviteState>(
      bloc: inviteCubit,
      listener: (consumerContext, state) {
        if (state.isSuccess) {
          _redirectSuccessScreen(context);
        }
      },
      builder: (BuildContext context, InviteState state) {
        if (state.isLoading) {
          return InviteScreenLoading();
        }

        if (state.isError) {
          return CustomScaffold(
            child: Center(
              child:
                  'Ops...\n houve um erro. Tente novamente'.labelIntro(context),
            ),
            appBar: _buildAppBar(context),
            bottomNavigationBar: null,
          );
        }

        return CustomScaffold(
          child: SingleChildScrollView(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildContent(context, state),
                ],
              ),
            ),
          ),
          appBar: _buildAppBar(context),
          bottomNavigationBar: _buildButtons(context),
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonDefault(
            text: 'Sim',
            width: SizeConfig.sizeByPixel(100),
            onTap: () {
              inviteCubit.syncUser();
            },
          ),
          SpacerBox.h16,
          CustomButtonDefault(
            text: 'Não',
            width: SizeConfig.sizeByPixel(100),
            swipeColors: true,
            onTap: () {
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, InviteState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomAvatar(
              radius: 40,
              backgroundImage: NetworkImage(state.userSyncInfoModel.photo),
            ),
            SpacerBox.h16,
            state.userSyncInfoModel.name
                .title(context, color: Theme.of(context).primaryColor),
          ],
        ),
        ..._divider(),
        'Deseja formar uma casal com você. O que vocês irão compartilhar:'
            .title(context),
        SpacerBox.v24,
        ..._buildShareContent(context),
        SpacerBox.v34,
        'Você quer prosseguir?'.title(context),
      ],
    );
  }

  List<Widget> _buildShareContent(BuildContext context) {
    return [
      CustomTile(
        title: 'Coisas para fazer',
        description: 'Aqui é o lugar para sair da mesmice. Procura o que fazer dentro ou fora de casa com o mozão ;)',
        iconStart: AppIcons.check,
        onTap: () {},
      ),
      ..._divider(),
      CustomTile(
        title: 'Linha do tempo',
        description: 'Monte uma linha do tempo privada contendo fotos de vocês',
        iconStart: AppIcons.check,
        onTap: () {},
      ),
      ..._divider(),
      CustomTile(
        title: 'Calendário de compromissos',
        description: 'Agende o que fazer para hoje e os próximos dias',
        iconStart: AppIcons.check,
        onTap: () {},
      ),
    ];
  }

  List<Widget> _divider() {
    return [
      SpacerBox.v16,
      CustomDivider(),
      SpacerBox.v16,
    ];
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Convite',
      context: context,
      onPressedBack: () {
        ExtendedNavigator.of(context).pop();
      },
      actions: <Widget>[],
    );
  }
}
