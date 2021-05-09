import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return CustomScaffold(
      child: SingleChildScrollView(
        child: CustomContainer(
          child: _buildChild(context),
        ),
      ),
      appBar: _buildAppBar(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonDefault(
          text: 'Sim',
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return BlocConsumer<UserActionCubit, UserActionState>(
      cubit: userActionCubit,
      listener: (consumerContext, state) {
        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          ExtendedNavigator.of(context).pop();
        }
      },
      builder: (BuildContext context, UserActionState state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildContent(context),
          ],
        );
      },
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
        onTap: () {
        },
      ),
      ..._divider(),
      CustomTile(
        title: 'Curtiu o Enjoy? Avalie-nos',
        description: 'Dá aquela 5 estrelas pra gente ;)',
        iconStart: AppIcons.thumbs_up,
        onTap: () {
        },
      ),
      ..._divider(),
      CustomTile(
        title: 'Curtiu o Enjoy? Avalie-nos',
        description: 'Dá aquela 5 estrelas pra gente ;)',
        iconStart: AppIcons.thumbs_up,
        onTap: () {
        },
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
        Navigator.of(context).pop();
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
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    final ButtonStyle _raisedButtonStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      minimumSize: Size(SizeConfig.screenWidth, 50),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );

    return ElevatedButton(
      style: _raisedButtonStyle,
      onPressed: () {
        onTap();
      },
      child: text.title(context, color: Theme.of(context).backgroundColor),
    );
  }
}
