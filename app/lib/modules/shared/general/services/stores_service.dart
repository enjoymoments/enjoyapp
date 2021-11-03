import 'dart:io';

import 'package:mozin/modules/shared/general/services/launch_url_service.dart';

class StoresService {
  static void redirectToStore(Function callbackPlatformNotFound) {
    if (Platform.isAndroid) {
      LaunchUrlService.launchURL(
          'https://play.google.com/store/apps/details?id=com.codefactory.mozin');
      return;
    } else if (Platform.isIOS) {
      LaunchUrlService.launchURL(
          'https://apps.apple.com/br/app/enjoy-moments/id1570943140');
      return;
    }

    callbackPlatformNotFound();
  }
}
