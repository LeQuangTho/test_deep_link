import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:test_deep_link/utils.dart';

class DynamicLinkService {
  Future handleDynamicLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    Map<String, dynamic>? param = _handleDynamicLink(data);

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      logger.w(dynamicLinkData.link);

      param = dynamicLinkData.utmParameters;
    }).onError((error) {
      logger.w(error.toString());
    });
    return param;
  }

  _handleDynamicLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      logger.w(deepLink.queryParameters["init"]);
      logger.w("Handel DeepLink | deepLink: $deepLink");

      return deepLink.queryParameters;
    }
  }
}
