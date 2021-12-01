class CalendarContentModel {
  CalendarContentModel({
    required this.selectedDate,
  });

  DateTime selectedDate;

  factory CalendarContentModel.initial() {
    return CalendarContentModel(
      selectedDate: DateTime.now(),
    );
  }

  void set({
    DateTime? selectedDate,
  }) {
    this.selectedDate = selectedDate ?? this.selectedDate;
  }
}
