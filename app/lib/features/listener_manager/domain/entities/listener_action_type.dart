
abstract class _Enum<T> {
  const _Enum._fromValue(this.value);

  final T value;

  @override
  String toString();
}

class ListenerActionTypeEnum extends _Enum<int> {
  factory ListenerActionTypeEnum(final int? value) {
    if (value == 1) {
      return ListenerActionTypeEnum.SyncCouple;
    } else if (value == 2) {
      return ListenerActionTypeEnum.UnsyncCouple;
    } else if (value == 3) {
      return ListenerActionTypeEnum.RefreshUserInfo;
    }

    return ListenerActionTypeEnum.Init;
  }

  const ListenerActionTypeEnum._fromValue(final int value) : super._fromValue(value);

  static const ListenerActionTypeEnum Init = ListenerActionTypeEnum._fromValue(0);
  static const ListenerActionTypeEnum SyncCouple = ListenerActionTypeEnum._fromValue(1);
  static const ListenerActionTypeEnum UnsyncCouple = ListenerActionTypeEnum._fromValue(2);
  static const ListenerActionTypeEnum RefreshUserInfo = ListenerActionTypeEnum._fromValue(3);

  @override
  String toString() => value.toString();
}