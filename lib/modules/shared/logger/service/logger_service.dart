import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/logger/models/logger_model.dart';
import 'package:mozin/modules/shared/logger/repository/logger_repository.dart';
import 'package:mozin/modules/shared/models/user_app_model.dart';
import 'package:mozin/modules/shared/services/device_info_service.dart';
import 'package:package_info/package_info.dart';

class LoggerService {
  LoggerService({
    @required this.loggerRepository,
    @required this.deviceInfoService,
    @required this.userAppModel,
  });

  final LoggerRepository loggerRepository;
  final DeviceInfoService deviceInfoService;
  final UserAppModel userAppModel;

  Future<void> addLogAsync(LoggerModel log) async {
    log.deviceInfo = await deviceInfoService.getDeviceInfo();

    final PackageInfo packageInfo = await getPackageInfoAsync();
    log.appName = packageInfo.appName;
    log.appVersion = packageInfo.version;
    log.packageName = packageInfo.packageName;

    log.login = userAppModel.email;

    loggerRepository.addLog(log);
  }

  //TODO:review
  // Future<dynamic> uploadFile(File file, String fileName) {
  //   return loggerRepository.uploadFile(sl<User>().id, file, fileName);
  // }

  Future<PackageInfo> getPackageInfoAsync() async {
    return await PackageInfo.fromPlatform();
  }
}
