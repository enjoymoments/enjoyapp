import 'package:flutter/material.dart';

class KeyValue<K,V> {
  final K key;
  final V value;

  KeyValue({@required this.key, @required this.value});
}