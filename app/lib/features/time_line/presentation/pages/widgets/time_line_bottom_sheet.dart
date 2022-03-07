import 'package:collection/collection.dart' show IterableExtension;
import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';

void showTimelineBottomSheet(BuildContext context, TimelineState state) {
  showMaterialModalBottomSheet(
    context: context,
    builder: (context) => CustomModalFit(
      items: _buildBottomSheetItem(state),
    ),
  );
}

List<CustomItemModalFit> _buildBottomSheetItem(TimelineState state) {
  if (state.timelineSelected!.type == TimeLineTypeEnum.Couple) {
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
  } else if (state.timelineSelected!.type == TimeLineTypeEnum.Personal) {
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

GetTimeLineModel? _findByType(TimelineState state, TimeLineTypeEnum type) {
  return state.timelines?.firstWhereOrNull((element) => element.type == type);
}
