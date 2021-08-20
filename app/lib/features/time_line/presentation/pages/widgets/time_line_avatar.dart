import 'package:auto_route/auto_route.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';

class TimeLineAddActions extends StatelessWidget {
  const TimeLineAddActions({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      cubit: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        if (getItInstance<UserService>().notAuthenticated() || state.timelineSelected == null) {
          return SizedBox.shrink();
        }

        return 
          IconButton(
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
  const TimeLineText({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      cubit: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        if (state.timelineSelected == null) {
          return Text('');
        }

        if(state.timelineSelected.type == TimeLineTypeEnum.Personal) {
          return Text('Minha linha do tempo');
        }

        return Text('Linha do tempo do casal');
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
      cubit: getItInstance<TimelineBloc>(),
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
        child: CustomAvatar(
          backgroundImage: _getBackgroundImage(state),
        ),
      );
    }

    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => CustomModalFit(
            items: _buildBottomSheetItem(state),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
        child: CustomAvatar(
          backgroundImage: _getBackgroundImage(state),
        ),
      ),
    );
  }

  List<CustomItemModalFit> _buildBottomSheetItem(TimelineState state) {
    if (state.timelineSelected.type == TimeLineTypeEnum.Couple) {
      return [
        CustomItemModalFit(
          text: 'Ir para minha linha do tempo',
          iconData: AppIcons.seedling,
          onTap: () {
            var _item = _findByType(state, TimeLineTypeEnum.Personal);
            getItInstance<TimelineBloc>().add(SelectedTimeline(_item));
          },
        ),
      ];
    } else if (state.timelineSelected.type == TimeLineTypeEnum.Personal) {
      return [
        CustomItemModalFit(
          text: 'Ir para linha do tempo do casal',
          iconData: AppIcons.seedling,
          onTap: () {
            var _item = _findByType(state, TimeLineTypeEnum.Couple);
            getItInstance<TimelineBloc>().add(SelectedTimeline(_item));
          },
        ),
      ];
    }

    return [];
  }

  GetTimeLineModel _findByType(TimelineState state, TimeLineTypeEnum type) {
    return state.timelines
        ?.firstWhere((element) => element.type == type, orElse: () => null);
  }

  ImageProvider _getBackgroundImage(TimelineState state) {
    if (state.timelineSelected.type == TimeLineTypeEnum.Couple) {
      return AssetImage('assets/images/default_avatar.png');
    }

    return null;
  }
}
