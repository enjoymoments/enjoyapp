import 'package:flutter/material.dart';
import 'package:mozin/views/shared/extension.dart';

class InterestCategoryItem extends StatefulWidget {
  const InterestCategoryItem(
      {Key key, @required this.model, @required this.callbackSelected})
      : super(key: key);

  final dynamic model;
  final Function(bool) callbackSelected;

  @override
  _InterestCategoryItemState createState() => _InterestCategoryItemState();
}

class _InterestCategoryItemState extends State<InterestCategoryItem> {
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
        margin: const EdgeInsets.only(bottom:10.0),
        padding: const EdgeInsets.all(20.0),
        decoration: myBoxDecoration(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.done,
              size: 30,
              color: _getTextColor(),
            ),
            "Alimentação".label(
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
    return _isSelected
        ? Theme.of(context).backgroundColor
        : Theme.of(context).iconTheme.color;
  }
}
