extension StringExtension on String {
  bool regexUrlHasMatch() {
    final Match? stringMatch = RegExp(
            r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
        .matchAsPrefix(this);

    return stringMatch != null;
  }
}
