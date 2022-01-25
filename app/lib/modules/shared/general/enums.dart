abstract class Enum<T> {
  const Enum._fromValue(this.value);

  final T value;

  @override
  String toString();
}

class InterestEnum extends Enum<int> {
  factory InterestEnum(final int value) {
    if (value == 1) {
      return InterestEnum.Place;
    } else if (value == 2) {
      return InterestEnum.SuggestedByUsers;
    }

    return InterestEnum.Init;
  }

  const InterestEnum._fromValue(final int value) : super._fromValue(value);

  static const InterestEnum Init = InterestEnum._fromValue(0);
  static const InterestEnum Place = InterestEnum._fromValue(1);
  static const InterestEnum SuggestedByUsers = InterestEnum._fromValue(2);

  @override
  String toString() => value.toString();
}

class MediaTypeEnum extends Enum<int> {
  factory MediaTypeEnum(final int value) {
    if (value == 1) {
      return MediaTypeEnum.Photo;
    }

    return MediaTypeEnum.Init;
  }

  const MediaTypeEnum._fromValue(final int value) : super._fromValue(value);

  static const MediaTypeEnum Init = MediaTypeEnum._fromValue(0);
  static const MediaTypeEnum Photo = MediaTypeEnum._fromValue(1);

  @override
  String toString() => value.toString();
}

class SourceTypeEnum extends Enum<int> {
  factory SourceTypeEnum(final int value) {
    if (value == 1) {
      return SourceTypeEnum.File;
    } else if (value == 2) {
      return SourceTypeEnum.Url;
    } else if (value == 3) {
      return SourceTypeEnum.Memory;
    }

    return SourceTypeEnum.Init;
  }

  const SourceTypeEnum._fromValue(final int value) : super._fromValue(value);

  static const SourceTypeEnum Init = SourceTypeEnum._fromValue(0);
  static const SourceTypeEnum File = SourceTypeEnum._fromValue(1);
  static const SourceTypeEnum Url = SourceTypeEnum._fromValue(2);
  static const SourceTypeEnum Memory = SourceTypeEnum._fromValue(3);

  @override
  String toString() => value.toString();
}

class DefaultMenuEnum extends Enum<int> {
  factory DefaultMenuEnum(final int? value, {required bool ignoreSearch}) {

    if (ignoreSearch) {
      if (value == 0) {
        return DefaultMenuEnum.Calendar;
      } else if (value == 1) {
        return DefaultMenuEnum.Me;
      }
    } else {
      if (value == 0) {
         return DefaultMenuEnum.Calendar;
      } else if (value == 1) {
          return DefaultMenuEnum.Search;
      } else if (value == 2) {
          return DefaultMenuEnum.Me;
      }
    }

    //TODO:review this - temporarily
    // if (ignoreSearch) {
    //   if (value == 0) {
    //     return DefaultMenuEnum.TimeLine;
    //   } else if (value == 1) {
    //     return DefaultMenuEnum.Calendar;
    //   } else if (value == 2) {
    //     return DefaultMenuEnum.Favorites;
    //   } else if (value == 3) {
    //     return DefaultMenuEnum.Me;
    //   }
    // } else {
    //   if (value == 0) {
    //     return DefaultMenuEnum.TimeLine;
    //   } else if (value == 1) {
    //     return DefaultMenuEnum.Calendar;
    //   } else if (value == 2) {
    //     return DefaultMenuEnum.Search;
    //   } else if (value == 3) {
    //     return DefaultMenuEnum.Favorites;
    //   } else if (value == 4) {
    //     return DefaultMenuEnum.Me;
    //   }
    // }

    return DefaultMenuEnum.Init;
  }

  const DefaultMenuEnum._fromValue(final int value) : super._fromValue(value);

  static const DefaultMenuEnum Init = DefaultMenuEnum._fromValue(-1);
  static const DefaultMenuEnum Calendar = DefaultMenuEnum._fromValue(0);
  //static const DefaultMenuEnum TimeLine = DefaultMenuEnum._fromValue(1);
  static const DefaultMenuEnum Search = DefaultMenuEnum._fromValue(2);
  static const DefaultMenuEnum Me = DefaultMenuEnum._fromValue(3);
  //static const DefaultMenuEnum Favorites = DefaultMenuEnum._fromValue(4);

  @override
  String toString() => value.toString();
}

class DynamicLinksTypeEnum extends Enum<String> {
  factory DynamicLinksTypeEnum(final String value) {
    if (value == 'sync') {
      return DynamicLinksTypeEnum.Sync;
    }

    return DynamicLinksTypeEnum.Init;
  }

  const DynamicLinksTypeEnum._fromValue(final String value) : super._fromValue(value);

  static const DynamicLinksTypeEnum Init = DynamicLinksTypeEnum._fromValue('');
  static const DynamicLinksTypeEnum Sync = DynamicLinksTypeEnum._fromValue('sync');

  @override
  String toString() => value.toString();
}

class NotificationTypeEnum extends Enum<String> {
  factory NotificationTypeEnum(final String? value) {
    if (value == 'CREATE_POST') {
      return NotificationTypeEnum.CreatePost;
    } else if (value == 'CREATE_ITEM_CALENDAR') {
      return NotificationTypeEnum.CreateItemCalendar;
    } else if (value == 'SYNC_COUPLE') {
      return NotificationTypeEnum.SyncCouple;
    } else if (value == 'UNSYNC_COUPLE') {
      return NotificationTypeEnum.UnsyncCouple;
    }

    return NotificationTypeEnum.Init;
  }

  const NotificationTypeEnum._fromValue(final String value) : super._fromValue(value);

  static const NotificationTypeEnum Init = NotificationTypeEnum._fromValue('');
  static const NotificationTypeEnum CreatePost = NotificationTypeEnum._fromValue('CREATE_POST');
  static const NotificationTypeEnum CreateItemCalendar = NotificationTypeEnum._fromValue('CREATE_ITEM_CALENDAR');
  static const NotificationTypeEnum SyncCouple = NotificationTypeEnum._fromValue('SYNC_COUPLE');
  static const NotificationTypeEnum UnsyncCouple = NotificationTypeEnum._fromValue('UNSYNC_COUPLE');

  @override
  String toString() => value.toString();
}

class TimeLineTypeEnum extends Enum<int> {
  factory TimeLineTypeEnum(final int? value) {
    if (value == 1) {
      return TimeLineTypeEnum.Personal;
    } else if (value == 2) {
      return TimeLineTypeEnum.Couple;
    }

    return TimeLineTypeEnum.Init;
  }

  const TimeLineTypeEnum._fromValue(final int value) : super._fromValue(value);

  static const TimeLineTypeEnum Init = TimeLineTypeEnum._fromValue(0);
  static const TimeLineTypeEnum Personal = TimeLineTypeEnum._fromValue(1);
  static const TimeLineTypeEnum Couple = TimeLineTypeEnum._fromValue(2);

  @override
  String toString() => value.toString();
}