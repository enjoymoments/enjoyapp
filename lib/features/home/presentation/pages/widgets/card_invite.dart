import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_content.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/rounded_loading_button.dart';

//TODO:share review this
class CardInvite extends StatefulWidget {
  @override
  _CardInviteState createState() => _CardInviteState();
}

class _CardInviteState extends State<CardInvite> {
  RoundedLoadingButtonController _actionButtoncontroller;
  InviteCubit _inviteCubit;

  @override
  void initState() {
    _actionButtoncontroller = RoundedLoadingButtonController();
    _inviteCubit = getItInstance<InviteCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<InviteCubit, InviteState>(
      cubit: _inviteCubit,
      listener: (consumerContext, state) {
        if (state.isSuccess) {
          _actionButtoncontroller.stop();
        }
      },
      builder: (context, state) {
        if (!state.isLoading) {
          return GestureDetector(
            onTap: () {
              _inviteCubit.generateShareUrl();
              //_actionButtoncontroller.start();
            },
            child: CardContent(
              iconData: AppIcons.inbox,
              name: 'Convidar meu par',
              description: 'O que pretende fazer nos próximos dias ?',
            ),
          );
        }

        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return RoundedLoadingButton(
      width: SizeConfig.sizeByPixel(50),
      controller: _actionButtoncontroller,
      child: CustomIcon(
        icon: AppIcons.check,
        color: Theme.of(context).appBarTheme.iconTheme.color,
      ),
      // onPressed: () {
      //   _actionButtoncontroller.stop();
      // },
    );
  }
}
