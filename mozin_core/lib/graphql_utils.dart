String formatParams(Map<String, dynamic> params,
    {List<String> nonStringValuesKeysAccount = const []}) {
  return params.entries
      .map((final MapEntry<String, dynamic> e) {
        if (nonStringValuesKeysAccount.contains(e.key)) {
          return '${e.key}: ${e.value}';
        }
        return '${e.key}: "${e.value}"';
      })
      .toList()
      .join(', ');
}
