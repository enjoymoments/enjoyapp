import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/config/router_external_resolver.dart';
import 'package:mozin/modules/config/setup.dart';

class ConfigureFirebaseDynamicLinks {
  void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri? deepLink = dynamicLinkData.link;

      if (deepLink != null) {
        getItInstance<RouterExternalResolver>()
            .resolver(context, path: deepLink.path);
      }
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink.path);
    }
  }
}
