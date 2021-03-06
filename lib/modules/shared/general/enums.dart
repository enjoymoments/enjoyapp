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
