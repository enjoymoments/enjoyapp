import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_container.dart';
import 'package:mozin/features/home/presentation/pages/widgets/card_content.dart';
import 'package:mozin/features/invite/presentation/bloc/invite_cubit.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';

class CardInvite extends StatelessWidget {
  const CardInvite({Key key, @required this.inviteCubit}) : super(key: key);
  final InviteCubit inviteCubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        inviteCubit.generateShareUrl();
      },
      child: CardContainer(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<InviteCubit, InviteState>(
      cubit: inviteCubit,
      listener: (consumerContext, state) {},
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _buildState(state),
        );
      },
    );
  }

  Widget _buildLoading() {
    return ButtonTheme(
      child: IconButton(
        padding: EdgeInsets.all(0),
        icon: SizedBox(
          height: SizeConfig.sizeByPixel(24.0),
          width: SizeConfig.sizeByPixel(24.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: SizeConfig.sizeByPixel(2.0),
          ),
        ),
        onPressed: null,
      ),
    );
  }

  Widget _buildState(InviteState state) {
    if (!state.isLoading) {
      return CardContent(
        iconData: AppIcons.inbox,
        name: 'Convidar meu par',
        description: 'O que pretende fazer nos próximos dias ?',
      );
    }

    return _buildLoading();
  }
}
