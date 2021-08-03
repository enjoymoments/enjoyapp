import 'package:flutter/material.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/extension.dart';

class InterestCategoryItem extends StatefulWidget {
  const InterestCategoryItem(
      {Key key, @required this.categorie, @required this.callbackSelected})
      : super(key: key);

  final CategoriesModel categorie;
  final Function(bool) callbackSelected;

  @override
  _InterestCategoryItemState createState() => _InterestCategoryItemState();
}

class _InterestCategoryItemState extends State<InterestCategoryItem> {
  bool _isSelected;

  @override
  void initState() {
    _isSelected =
        widget.categorie.selected != null && widget.categorie.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _buildCardItem(context);
  }

  Widget _buildCardItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isSelected = !_isSelected;
        widget.callbackSelected(_isSelected);

        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(20.0),
        width: SizeConfig.sizeByPixel(140),
        decoration: myBoxDecoration(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(
              icon: AppIcons.check,
              color: _getTextColor(),
            ),
            widget.categorie.name.label(
              context,
              color: _getTextColor(),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getBackgroundColor(),
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  Color _getBackgroundColor() {
    return _isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).hintColor;
  }

  Color _getTextColor() {
    if (_isSelected) {
      return Theme.of(context).backgroundColor;
    }

    return null;
  }
}
