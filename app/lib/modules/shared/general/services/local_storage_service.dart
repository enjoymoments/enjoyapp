import 'package:hive/hive.dart';
import 'package:custom_utilities/custom_utilities.dart';

class LocalStorageService {
  final Box<dynamic> box;

  LocalStorageService(this.box);

  Future put<Key, Value>(KeyValue<Key, Value> keyValuePair) async {
    box.put(keyValuePair.key, keyValuePair.value);
  }

  Future<Value?> get<Key, Value>(Key key) async {
    return box.get(key);
  }

  bool containsKey(String key) {
    return box.containsKey(key);
  }

  Future<int> clearAll() {
    return box.clear();
  }
}
