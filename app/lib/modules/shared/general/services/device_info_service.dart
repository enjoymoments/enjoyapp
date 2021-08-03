import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfoService {
  Future<Map<String, dynamic>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      return _getMapAndroidInfo(deviceInfo);
    } else if (Platform.isIOS) {
      return _getMapIOSInfo(deviceInfo);
    }

    return Future.value(Map<String,dynamic>());
  }

  Future<Map<String, dynamic>> _getMapAndroidInfo(
      DeviceInfoPlugin deviceInfo) async {
    final AndroidDeviceInfo build = await deviceInfo.androidInfo;
    return <String, dynamic>{
      'securityPatch': build.version.securityPatch,
      'sdkInt': build.version.sdkInt,
      'release': build.version.release,
      'previewSdkInt': build.version.previewSdkInt,
      'incremental': build.version.incremental,
      'codename': build.version.codename,
      'baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Future<Map<String, dynamic>> _getMapIOSInfo(
      DeviceInfoPlugin deviceInfo) async {
    final IosDeviceInfo data = await deviceInfo.iosInfo;
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'sysname': data.utsname.sysname,
      'nodename': data.utsname.nodename,
      'release': data.utsname.release,
      'version': data.utsname.version,
      'machine': data.utsname.machine,
    };
  }
}
