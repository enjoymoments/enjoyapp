import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

//TODO:share review this
class ConfigureFirebaseDynamicLinks {
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      print(deepLink.path);
      if (deepLink != null) {
        print(deepLink.path);
        // Navigator.pushNamed(context, deepLink.path);
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
      //Navigator.pushNamed(context, deepLink.path);
    }
  }
}
