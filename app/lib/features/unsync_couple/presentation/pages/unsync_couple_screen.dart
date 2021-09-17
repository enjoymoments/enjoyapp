import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/unsync_couple/presentation/bloc/unsync_couple/unsynccouple_cubit.dart';
import 'package:mozin/features/unsync_couple/presentation/pages/widgets/unsync_couple_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_button_default.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/custom_gif.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/custom_tile.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class UnsyncCoupleScreen extends StatefulWidget {
  const UnsyncCoupleScreen({
    Key key,
  }) : super(key: key);

  @override
  _UnsyncCoupleScreenState createState() => _UnsyncCoupleScreenState();
}

class _UnsyncCoupleScreenState extends State<UnsyncCoupleScreen> {
  UnsyncCoupleCubit _unsyncCoupleCubit;

  @override
  void initState() {
    _unsyncCoupleCubit = getItInstance<UnsyncCoupleCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _unsyncCoupleCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnsyncCoupleCubit, UnsyncCoupleState>(
      bloc: _unsyncCoupleCubit,
      listener: (consumerContext, state) {
        if (state.isSuccess) {
          _redirectSuccessScreen(context);
        }
      },
      builder: (BuildContext context, UnsyncCoupleState state) {
        if (state.isLoading) {
          return UnsyncCoupleScreenLoading();
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
                  _buildContent(context),
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

  void _redirectSuccessScreen(BuildContext context) {
    ExtendedNavigator.of(context).popAndPush(
      Routes.success_screen,
      arguments: CustomSuccessScreenArguments(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            'OK, tudo certo !'.labelIntro(context),
            SpacerBox.v24,
            CustomGif(path: 'assets/images/thanks.webp'),
          ],
        ),
      ),
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
              _unsyncCoupleCubit.unsyncCouple();
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

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Ao desvincular com o parceiro(a), vocês deixaram de compartilhar: '
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
        title: 'Linha do tempo',
        description:
            'Monte uma linha do tempo privada contendo fotos de vocês',
        iconStart: AppIcons.check,
        onTap: () {},
      ),
      ..._divider(),
      CustomTile(
        title: 'Calendário de compromissos',
        description:
            'Agende o que fazer para hoje e os próximos dias',
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
      title: 'Desvincular',
      context: context,
      onPressedBack: () {
        ExtendedNavigator.of(context).pop();
      },
      actions: <Widget>[],
    );
  }
}
