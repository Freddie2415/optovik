import 'package:flutter/material.dart';
import 'package:optovik/generated/l10n.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.info),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/info-banner.jpg"),
          ListTile(
            title: Text(
              S.current.offer,
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              S.current.delivery,
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              S.current.privacyPolicy,
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
