import 'package:flutter/material.dart';

class DeleteConfirmationModalFit extends StatelessWidget {
  final ScrollController scrollController;
  final Function deleteConfirmed;

  const DeleteConfirmationModalFit({
    Key key,
    @required this.deleteConfirmed,
    @required this.scrollController,
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
              title: Text('Sim'),
              leading: Icon(Icons.done),
              onTap: () {
                Navigator.of(context).pop();
                deleteConfirmed();
              },
            ),
            ListTile(
              title: Text('Não'),
              leading: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
