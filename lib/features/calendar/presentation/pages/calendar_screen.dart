import 'package:flutter/material.dart';
import 'package:mozin/features/calendar/presentation/pages/calendar_content.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: CalendarContent(),
      appBar: _buildAppBar(),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Calendário',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        // if (_images.length > 0 ||
        //     (_descriptionController.text != null &&
        //         _descriptionController.text.isNotEmpty)) {
        //   _discardPost(context);
        //   return;
        // }

        Navigator.of(context).pop();
      },
      actions: <Widget>[
        IconButton(
          icon: CustomIcon(icon: AppIcons.plus),
          onPressed: () {
            
          },
        ),
      ],
    );
  }
}
