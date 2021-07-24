import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/shared/general/models/media_model.dart';

extension NavigatorStateExtension on ExtendedNavigatorState {
  void pushNamedIfNotCurrent(String routeName, {Object arguments}) {
    if (!isCurrent(routeName)) {
      push(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(this.year, this.month, this.day, time.hour, time.minute);
  }

  TimeOfDay timeOfDayFromDateTime() {
    return TimeOfDay(hour: this.hour, minute: this.minute);
  }

  DateTime clearTime() {
    return DateTime(this.year, this.month, this.day, 0, 0, 0, 0, 0);
  }

  String formattedHourMinute() {
    return DateFormat().add_Hm().format(this);
  }

  DateFormat dateCustomFormat(String pattern) {
    return DateFormat(pattern);
  }

  String dateOnlyFormat() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension ListWidget on List {
  List<Widget> buildWithBetweenSpace<T>({
    @required Widget Function(T item) builderItem,
    @required Widget space,
  }) {
    List<Widget> _result = List<Widget>();

    for (var item in this) {
      _result.add(builderItem(item));
      _result.add(space);
    }

    return _result;
  }
}

extension Snackbar on BuildContext {
  void showSnackBar(String message) {
    Scaffold.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

extension Texts on String {
  Widget iconWithLabel(
    BuildContext context, {
    Color color,
    double fontSize = 18,
  }) {
    return Text(
      this,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }

  Widget description(BuildContext context,
          {double fontSize = 18,
          TextAlign textAlign,
          int maxLines,
          Color color,
          TextDecoration decoration,
          double letterSpacing,
          FontWeight fontWeight}) =>
      AutoSizeText(
        this,
        textAlign: textAlign,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.headline4.copyWith(
            fontSize: fontSize,
            decoration: decoration,
            color: color ?? Theme.of(context).textTheme.headline5.color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight),
      );

  Widget date(
    BuildContext context, {
    double fontSize = 13,
    Color color,
    int maxLines,
    double letterSpacing,
    FontWeight fontWeight,
  }) {
    return AutoSizeText(
      this,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.headline4.copyWith(
            fontSize: fontSize,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
          ),
    );
  }

  Widget title(
    BuildContext context, {
    double fontSize = 22,
    Color color,
    int maxLines,
    double letterSpacing,
    FontWeight fontWeight,
  }) {
    return AutoSizeText(
      this,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.headline5.copyWith(
            fontSize: fontSize,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
          ),
    );
  }

  Widget label(
    BuildContext context, {
    bool withoutAutoSize = false,
    double fontSize = 20,
    Color color,
    int maxLines = 2,
    double letterSpacing,
    FontWeight fontWeight,
  }) {
    if (withoutAutoSize == true) {
      return Text(
        this,
        style: Theme.of(context).textTheme.headline5.copyWith(
              fontSize: fontSize,
              color: color,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
            ),
      );
    }

    return AutoSizeText(
      this,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.headline5.copyWith(
            fontSize: fontSize,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
          ),
    );
  }

  Widget labelIntro(
    BuildContext context, {
    Color color,
  }) {
    return AutoSizeText(
      this,
      style: TextStyle(
          color: color ?? Theme.of(context).primaryColor, fontSize: 28),
      textAlign: TextAlign.center,
    );
  }
}

extension ImageToGallery on List<MediaModel> {
  List<GalleryImageModel> toGalleryImages() {
    final List<GalleryImageModel> galleryItems = [];

    for (var i = 0; i < this.length; i++) {
      var item = this[i];
      galleryItems.add(
        GalleryImageModel(
          id: item.id,
          index: i,
          //file: item,
          url: item.url,
        ),
      );
    }

    return galleryItems;
  }
}
