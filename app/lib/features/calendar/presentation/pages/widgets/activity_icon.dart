import 'package:flutter/material.dart';
import 'package:mozin/features/calendar/data/models/activity_item_model.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class ActivityIcon extends StatefulWidget {
  final ActivityItemModel item;
  final void Function(ActivityItemModel? item) onPressed;

  const ActivityIcon({
    Key? key,
    required this.onPressed,
    required this.item,
  }) : super(key: key);
  @override
  _ActivityIconState createState() => _ActivityIconState();
}

class _ActivityIconState extends State<ActivityIcon> {
  ActivityItemModel? _item;

  @override
  void initState() {
    _item = widget.item;
    super.initState();
  }

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
              //TODO:for test
              Icons.ac_unit,
              // _item.codePoint == null
              //     ? AppIcons.trailer
              //     : IconData(_item.codePoint,
              //         fontFamily: 'AppIcons', fontPackage: null),
              color: _getIconColor(),
            ),
            onPressed: () {
              _item = _item!.copyWith(isSelected: !_item!.isSelected!);
              setState(() {
                widget.onPressed(_item);
              });
            },
          ),
        ),
        _item!.name!.description(
          context,
        ),
      ],
    );
  }

  Color _getBackgroundColor() {
    return _item!.isSelected!
        ? Theme.of(context).primaryColor
        : Theme.of(context).hintColor;
  }

  Color _getIconColor() {
    if (_item!.isSelected!) {
      return Theme.of(context).backgroundColor;
    }

    return Theme.of(context).primaryColor;
  }
}
