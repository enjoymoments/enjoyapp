import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/actions/delete_confirmation_modal_fit.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/body_card.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/enum/action_header_enum.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/header_card.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class TimeLineItem extends StatelessWidget {
  const TimeLineItem(
      {Key key, @required this.item, @required this.timelineBloc})
      : super(key: key);

  final TimeLineItemModel item;
  final TimelineBloc timelineBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpacerBox.v4,
        HeaderCard(
          item: item,
          callback: (action) {
            _invokeActionsHeader(context, action);
          },
        ),
        SpacerBox.v8,
        BodyCard(item: item),
        //TODO:review
        //FooterCard(),
        SpacerBox.v4,
      ],
    );
  }

  void _invokeActionsHeader(BuildContext context, ActionHeaderEnum action) {
    if (action == ActionHeaderEnum.DELETE) {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context, scrollController) => DeleteConfirmationModalFit(
          scrollController: scrollController,
          deleteConfirmed: () {
            timelineBloc.add(DeletePost(item));
          },
        ),
      );
    }
  }
}
