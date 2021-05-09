import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/invite/presentation/pages/widgets/invite_screen_loading.dart';
import 'package:mozin/features/user_action/presentation/bloc/user_action/user_action_cubit.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_avatar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_tile.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({
    Key key,
    @required this.userActionCubit,
  }) : super(key: key);

  final UserActionCubit userActionCubit;

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return BlocConsumer<UserActionCubit, UserActionState>(
      cubit: userActionCubit,
      listener: (consumerContext, state) {
        if (state.isSuccess) {
          ExtendedNavigator.of(context).pop();
        }
      },
      builder: (BuildContext context, UserActionState state) {
        if (state.isLoading) {
          return InviteScreenLoading();
        }

        if (state.isError) {
          return CustomScaffold(
            child: Center(
              child: 'Ops, houve um erro. Tente novamente'.labelIntro(context),
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
                  _buildContent(context),
                ],
              ),
            ),
          ),
          appBar: _buildAppBar(context),
          bottomNavigationBar: _buildButtons(),
        );
      },
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonDefault(
            text: 'Sim',
            width: SizeConfig.sizeByPixel(100),
            onTap: () {},
          ),
          SpacerBox.h16,
          ButtonDefault(
            text: 'Não',
            width: SizeConfig.sizeByPixel(100),
            swipeColors: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomAvatar(
              radius: 40,
            ),
            SpacerBox.h16,
            'FELIPE AUGUSTO'
                .title(context, color: Theme.of(context).primaryColor),
          ],
        ),
        ..._divider(),
        'Deseja formar uma casal com você. O que vocês irão compartilhar:'
            .title(context),
        SpacerBox.v34,
        ..._buildShareContent(context),
        SpacerBox.v34,
        'Você quer prosseguir?'.title(context),
      ],
    );
  }

  List<Widget> _buildShareContent(BuildContext context) {
    return [
      CustomTile(
        title: 'Curtiu o Enjoy? Avalie-nos',
        description: 'Dá aquela 5 estrelas pra gente ;)',
        iconStart: AppIcons.thumbs_up,
        onTap: () {},
      ),
      ..._divider(),
      CustomTile(
        title: 'Curtiu o Enjoy? Avalie-nos',
        description: 'Dá aquela 5 estrelas pra gente ;)',
        iconStart: AppIcons.thumbs_up,
        onTap: () {},
      ),
      ..._divider(),
      CustomTile(
        title: 'Curtiu o Enjoy? Avalie-nos',
        description: 'Dá aquela 5 estrelas pra gente ;)',
        iconStart: AppIcons.thumbs_up,
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

class ButtonDefault extends StatelessWidget {
  const ButtonDefault({
    Key key,
    @required this.text,
    @required this.onTap,
    this.width,
    this.height,
    this.swipeColors,
  }) : super(key: key);

  final String text;
  final Function onTap;
  final double width;
  final double height;
  final bool swipeColors;

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    final ButtonStyle _raisedButtonStyle = ElevatedButton.styleFrom(
      primary: swipeColors == true
          ? Theme.of(context).backgroundColor
          : Theme.of(context).primaryColor,
      minimumSize: Size(width ?? SizeConfig.screenWidth, height ?? 50),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );

    return ElevatedButton(
      style: _raisedButtonStyle,
      onPressed: () {
        onTap();
      },
      child: text.title(context,
          color: swipeColors == true
              ? Theme.of(context).primaryColor
              : Theme.of(context).backgroundColor),
    );
  }
}
