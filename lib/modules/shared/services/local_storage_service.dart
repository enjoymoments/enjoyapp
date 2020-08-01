import 'package:hive/hive.dart';
import 'package:mozin/modules/shared/models/key_value.dart';

class LocalStorageService {

  final Box<dynamic> box;

  LocalStorageService(this.box);

  Future put<Key, Value>(KeyValue<Key, Value> keyValuePair) async {
    box.put(keyValuePair.key, keyValuePair.value);
  }

  Future<Value> get<Key, Value>(Key key) async {
    return box.get(key);
  }
}
