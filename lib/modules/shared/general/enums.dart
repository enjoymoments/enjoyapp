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
    }

    return null;
  }

  const InterestEnum._fromValue(final int value) : super._fromValue(value);

  static const InterestEnum Place = InterestEnum._fromValue(1);

  @override
  String toString() => value.toString();
}

class MediaTypeEnum extends Enum<int> {
  factory MediaTypeEnum(final int value) {
    if (value == 1) {
      return MediaTypeEnum.Photo;
    }

    return null;
  }

  const MediaTypeEnum._fromValue(final int value) : super._fromValue(value);

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
    }

    return null;
  }

  const SourceTypeEnum._fromValue(final int value) : super._fromValue(value);

  static const SourceTypeEnum File = SourceTypeEnum._fromValue(1);
  static const SourceTypeEnum Url = SourceTypeEnum._fromValue(2);

  @override
  String toString() => value.toString();
}

class DefaultMenuEnum extends Enum<int> {
  factory DefaultMenuEnum(final int value) {
    if (value == 0) {
      return DefaultMenuEnum.Home;
    } else if (value == 1) {
      return DefaultMenuEnum.TimeLine;
    } else if (value == 2) {
      return DefaultMenuEnum.Search;
    } else if (value == 3) {
      return DefaultMenuEnum.Me;
    } else if (value == 4) {
      return DefaultMenuEnum.Monitoring;
    }

    return null;
  }

  const DefaultMenuEnum._fromValue(final int value) : super._fromValue(value);

  static const DefaultMenuEnum Home = DefaultMenuEnum._fromValue(0);
  static const DefaultMenuEnum TimeLine = DefaultMenuEnum._fromValue(1);
  static const DefaultMenuEnum Search = DefaultMenuEnum._fromValue(2);
  static const DefaultMenuEnum Me = DefaultMenuEnum._fromValue(3);
  static const DefaultMenuEnum Monitoring = DefaultMenuEnum._fromValue(4);

  @override
  String toString() => value.toString();
}
