import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_avatar.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class TimeLineAvatar extends StatelessWidget {
  const TimeLineAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      cubit: getItInstance<TimelineBloc>(),
      builder: (context, state) {
        var _item = _getTimelineItem(state);
        if (_item == null) {
          return SizedBox.shrink();
        }

        return _buildAvatar(context, state, _item);
      },
    );
  }

  Widget _buildAvatar(
      BuildContext context, TimelineState state, GetTimeLineModel item) {
    if (state.timelines.length < 2) {
      return Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
        child: CustomAvatar(
          backgroundImage: _getBackgroundImage(item),
        ),
      );
    }

    return InkWell(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => CustomModalFit(
            items: [
              CustomItemModalFit(
                text: 'Não quero remover',
                iconData: AppIcons.ad,
                onTap: () {},
              ),
              CustomItemModalFit(
                text: 'Sim, quero remover',
                iconData: AppIcons.trash,
                onTap: () {},
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByPixel(8)),
        child: CustomAvatar(
          backgroundImage: _getBackgroundImage(item),
        ),
      ),
    );
  }

  GetTimeLineModel _getTimelineItem(TimelineState state) {
    if (state.timelines?.length == 0) {
      return null;
    }

    var _item = _findByType(state, TimeLineTypeEnum.Couple);

    if (_item != null) {
      return _item;
    }

    _item = _findByType(state, TimeLineTypeEnum.Personal);

    if (_item != null) {
      return _item;
    }

    return null;
  }

  GetTimeLineModel _findByType(TimelineState state, TimeLineTypeEnum type) {
    return state.timelines
        ?.firstWhere((element) => element.type == type, orElse: () => null);
  }

  ImageProvider _getBackgroundImage(GetTimeLineModel item) {
    if (item.type == TimeLineTypeEnum.Couple) {
      return AssetImage('assets/images/default_avatar.png');
    }

    return null;
  }
}
