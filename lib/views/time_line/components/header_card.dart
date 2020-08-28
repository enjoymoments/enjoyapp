import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/views/shared/custom_modal_fit.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/time_line/components/enum/action_header_enum.dart';

class HeaderCard extends StatelessWidget {
  final Function(ActionHeaderEnum) callback;
  final TimeLineItemModel item;

  const HeaderCard({
    Key key,
    @required this.item,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            item.dateCreationFormatted.date(context),
            IconButton(
              icon: new Icon(Icons.more_horiz),
              iconSize: Theme.of(context).iconTheme.size,
              onPressed: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context, scrollController) => CustomModalFit(
                    scrollController: scrollController,
                    onTapDelete: () {
                      callback(ActionHeaderEnum.DELETE);
                    },
                  ),
                );
              },
            ),
          ],
        ),
        "Foi maravilhosa a viajem que fizemos, amei estar com você vivendo essa experiência."
            .description(context),
      ],
    );
  }
}
