import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:mozin/modules/config/router_external_resolver.dart';
import 'package:mozin/modules/config/setup.dart';

//TODO:share review this
class ConfigureFirebaseDynamicLinks {
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        //TODO:review this
        getItInstance<RouterExternalResolver>().resolver(null, path: deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink.path);
    }
  }
}
