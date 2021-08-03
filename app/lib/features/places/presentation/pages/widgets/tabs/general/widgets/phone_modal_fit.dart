import 'package:flutter/material.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneModalFit extends StatelessWidget {
  final String phoneNumber;

  const PhoneModalFit({Key key, @required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: "Ligar para $phoneNumber".label(context),
              leading: Icon(Icons.phone),
              onTap: () {
                _tapPhoneNumber();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _tapPhoneNumber() {
    final Uri _phoneNumberLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    launch(_phoneNumberLaunchUri.toString());
  }
}
