import 'package:device_info/device_info.dart';

class DeviceInfoService {
  Future<AndroidDeviceInfo> getAndroidInfo() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return deviceInfo.androidInfo;
  }

  Future<IosDeviceInfo> getIOSInfo() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return deviceInfo.iosInfo;
  }
}
