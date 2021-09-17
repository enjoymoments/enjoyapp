import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class SessionModel {
  final InterestEnum type;
  bool selected;
  final String text;

  SessionModel({required this.type, required this.selected, required this.text});
}