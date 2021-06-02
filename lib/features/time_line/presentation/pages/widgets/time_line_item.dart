import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/body_card.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/enum/action_header_enum.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/header_card.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/spacer_box.dart';

class TimeLineItem extends StatelessWidget {
  const TimeLineItem(
      {Key key, @required this.item, @required this.timelineBloc})
      : super(key: key);

  final TimeLineItemModel item;
  final TimelineBloc timelineBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
      ],
    );
  }

  void _invokeActionsHeader(BuildContext context, ActionHeaderEnum action) {
    if (action == ActionHeaderEnum.DELETE) {
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => CustomModalFit(
          items: [
            CustomItemModalFit(
              text: 'Sim',
              iconData: AppIcons.check,
              onTap: () {
                timelineBloc.add(DeletePost(item));
              },
            ),
            CustomItemModalFit(
              text: 'Não',
              iconData: AppIcons.times,
              onTap: () {},
            ),
          ],
        ),
      );
    }
  }
}
