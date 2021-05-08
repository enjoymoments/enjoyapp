import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/user_action/presentation/bloc/user_action/user_action_cubit.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({
    Key key,
    @required this.userActionCubit,
  }) : super(key: key);

  final UserActionCubit userActionCubit;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildContent(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildContent() {
    return BlocConsumer<UserActionCubit, UserActionState>(
      cubit: userActionCubit,
      listener: (consumerContext, state) {
        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          //ExtendedNavigator.of(context).pop();
        }
      },
      builder: (BuildContext context, UserActionState state) {
        return Center(
          child: 'Test'.title(context),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Convidar',
      context: context,
      onPressedBack: () {
        Navigator.of(context).pop();
      },
      actions: <Widget>[],
    );
  }
}
