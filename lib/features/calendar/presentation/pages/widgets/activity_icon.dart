import 'package:flutter/material.dart';
import 'package:mozin/features/calendar/data/models/activity_item_model.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class ActivityIcon extends StatefulWidget {
  final ActivityItemModel item;

  const ActivityIcon({Key key, @required this.item}) : super(key: key);
  @override
  _ActivityIconState createState() => _ActivityIconState();
}

class _ActivityIconState extends State<ActivityIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpacerBox.v8,
        Container(
          width: SizeConfig.sizeByPixel(50.0),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          child: IconButton(
            icon: Icon(
              IconData(widget.item.codePoint,
                  fontFamily: 'AppIcons', fontPackage: null),
              color: _getIconColor(),
            ),
            onPressed: () {
              setState(() {
                widget.item.isSelected = !widget.item.isSelected;
              });
            },
          ),
        ),
        widget.item.name.description(
          context,
        ),
      ],
    );
  }

  Color _getBackgroundColor() {
    return widget.item.isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).hintColor;
  }

  Color _getIconColor() {
    if (widget.item.isSelected) {
      return Theme.of(context).backgroundColor;
    }

    return Theme.of(context).primaryColor;
  }
}
