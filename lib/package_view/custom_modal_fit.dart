import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomModalFit extends StatelessWidget {
  final ScrollController scrollController;
  final Function onTapDelete;

  const CustomModalFit({
    Key key,
    @required this.scrollController,
    @required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Deletar'),
              leading: Icon(Icons.delete),
              onTap: () {
                ExtendedNavigator.of(context).pop();
                onTapDelete();
              },
            )
          ],
        ),
      ),
    );
  }
}
