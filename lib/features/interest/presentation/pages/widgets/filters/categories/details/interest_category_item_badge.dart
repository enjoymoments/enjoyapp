import 'package:flutter/material.dart';
import 'package:mozin/package_view/extension.dart';

class InterestCategoryItemBadge extends StatefulWidget {
  const InterestCategoryItemBadge(
      {Key key, @required this.model, @required this.callbackSelected})
      : super(key: key);

  final dynamic model;
  final Function(bool) callbackSelected;

  @override
  _InterestCategoryItemBadgeState createState() =>
      _InterestCategoryItemBadgeState();
}

class _InterestCategoryItemBadgeState extends State<InterestCategoryItemBadge> {
  bool _isSelected;

  @override
  void initState() {
    _isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        alignment: Alignment.center,
        width: 95, //TODO:review
        decoration: myBoxDecoration(context),
        child: "Alimentação".label(
          context,
          color: _getTextColor(),
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
