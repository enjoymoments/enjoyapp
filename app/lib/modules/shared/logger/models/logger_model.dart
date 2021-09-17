import 'package:flutter/widgets.dart';
import 'package:mozin/modules/shared/logger/enums/logger_type_enum.dart';

class LoggerModel {
  LoggerModel(
      {required this.typeError, required this.message, required this.error, required this.extraInfo});

  String? login;
  String? appName;
  String? packageName;
  String? appVersion;
  Map<String, dynamic>? deviceInfo;

  final Map<String, dynamic> error;
  final Map<String, dynamic> extraInfo;
  final String? message;
  final LoggerTypeEnum typeError;
}
