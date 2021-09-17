import 'package:auto_route/auto_route.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/custom_view.dart';
import 'package:custom_view/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/time_line_bottom_sheet.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';

class TimeLineAddActions extends StatelessWidget {
  const TimeLineAddActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      bloc: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        if (getItInstance<UserService>().notAuthenticated() ||
            state.timelineSelected == null) {
          return SizedBox.shrink();
        }

        return IconButton(
          icon: CustomIcon(icon: AppIcons.plus),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.add_time_line_screen);
          },
        );
      },
    );
  }
}

class TimeLineText extends StatelessWidget {
  const TimeLineText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      bloc: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        if (state.timelineSelected == null) {
          return Text('');
        }

        String _textTitle = 'Linha do tempo do casal';

        if (state.timelineSelected.type == TimeLineTypeEnum.Personal) {
          _textTitle = 'Minha linha do tempo';
        }

        if (state.timelines.length == 1) {
          return Text(_textTitle);
        }

        return InkWell(
          onTap: () {
            showTimelineBottomSheet(context, state);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_textTitle),
              SpacerBox.h8,
              Icon(
                AppIcons.chevron_down,
                size: 14,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TimeLineAvatar extends StatelessWidget {
  const TimeLineAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      bloc: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        if (state.timelineSelected == null) {
          return SizedBox.shrink();
        }

        return _buildAvatar(context, state);
      },
    );
  }

  Widget _buildAvatar(BuildContext context, TimelineState state) {
    if (state.timelines.length == 1) {
      return Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
        child: Row(
          children: [
            CustomAvatar(
              backgroundImage: _getBackgroundImage(state),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        showTimelineBottomSheet(context, state);
      },
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
        child: CustomAvatar(
          backgroundImage: _getBackgroundImage(state),
        ),
      ),
    );
  }

  ImageProvider _getBackgroundImage(TimelineState state) {
    if (state.timelineSelected.type == TimeLineTypeEnum.Couple) {
      return AssetImage('assets/images/default_avatar.png');
    }

    return null;
  }
}
