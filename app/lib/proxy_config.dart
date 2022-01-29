import 'dart:convert';
import 'dart:io';

import 'package:custom_utilities/custom_utilities.dart';
import 'package:flutter/foundation.dart';

class ProxyConfig {
  static void config(HttpClient httpClient, SecurityContext ctx) {
    if (isInDebugMode) {
      _config01(httpClient);
      _config02(ctx);
    }
  }

  static void _config01(HttpClient httpClient) {
    if (kDebugMode) {
      //set your IpAddress here
      httpClient.findProxy = (uri) => 'PROXY 192.168.0.3:8080;';
    }
  }

  static void _config02(SecurityContext ctx) {
    if (kDebugMode) {
      const String content = '''-----BEGIN CERTIFICATE-----
MIIDoTCCAomgAwIBAgIGDqmxPLOBMA0GCSqGSIb3DQEBCwUAMCgxEjAQBgNVBAMM
CW1pdG1wcm94eTESMBAGA1UECgwJbWl0bXByb3h5MB4XDTIxMDEzMDE2NTYyMFoX
DTI0MDIwMTE2NTYyMFowKDESMBAGA1UEAwwJbWl0bXByb3h5MRIwEAYDVQQKDAlt
aXRtcHJveHkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9A3CQaFL3
7aDLnBsIRnHDYF1YDJs1KSxklaKXL6GcwGxhWqkMb9oFNfH2bBiIWEYvPg8Dg0qG
9U/1LESg1aYpsbDbHSL39xzwr1fqR+Z2JpjWGpkE3dOEEv35STti+25X5KCbigJI
D7MCNZL6w0mtffTUldubtcXBxLG2jJNMyRUGhLUuw7F0FOagXUdngwZd4lVsqSlA
clUPKJPpA9QTuMOIoOtwV4pMDTVO6mcgYbNRMXVxWDr7Q8/L0ZSpqc5hjkhnRWQB
JDIRtnOdVn0T29N/1MPuBfFp80nTq4EFmnOhyJ0cd6L9u32odqwSIsr71505LbXy
GF7BaY9s71D9AgMBAAGjgdAwgc0wDwYDVR0TAQH/BAUwAwEB/zARBglghkgBhvhC
AQEEBAMCAgQweAYDVR0lBHEwbwYIKwYBBQUHAwEGCCsGAQUFBwMCBggrBgEFBQcD
BAYIKwYBBQUHAwgGCisGAQQBgjcCARUGCisGAQQBgjcCARYGCisGAQQBgjcKAwEG
CisGAQQBgjcKAwMGCisGAQQBgjcKAwQGCWCGSAGG+EIEATAOBgNVHQ8BAf8EBAMC
AQYwHQYDVR0OBBYEFEOQ3Q7wY3i0MTUyk+wYBP5OS1iiMA0GCSqGSIb3DQEBCwUA
A4IBAQBAPLXPiQ/MyBG1HvKy4Rw+OKsCqCNCwwIkwghypG5ow//Kr0ViXzE8AdWL
fW+/jG8rf/U4I89je/kPy6F5+ITQna4J2VOVRbIS0/u/GYVYj50dk8VjFwrqTZuj
oL2nx9C+Kevpt1L8HwiVBsQSj6aC1azLOiDxXciJGe0xyITLiTXI7S7URQp0Za8B
vQ9WWbrBr64aie2VG5SjswTfyXsoxBcF3gSOdTD//TPYPOzRZm4fXvBeUrcoMUAY
2vX/6jAPnkfIbO3QKFTNBb+tzEDZ+KEJR6lDSpYCgI18TtsPvG4ANqWIEDB1r1NY
UA/lpsA2jF0QCqKLvyF8kG0r8GjK
-----END CERTIFICATE-----
''';

      final List<int> data = utf8.encode(content);

      ctx.setTrustedCertificatesBytes(data);
    }
  }
}
