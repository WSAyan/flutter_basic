import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/local/pref_helper.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/routes.dart' as routes;
import 'package:share/share.dart';

class SideNavDrawer extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(AppStrings.HOME_SCREEN_TITLE),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(AppStrings.USERS_SCREEN_TITLE),
            onTap: () {
              Navigator.of(context).pushNamed(routes.USERS);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(AppStrings.SHARE),
            onTap: () {
              onShare(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(AppStrings.LOGOUT_BUTTON),
            onTap: logout,
          ),
        ],
      ),
    );
  }

  void logout() {
    SharedPrefHelper().destroy();
    Navigator.of(context).pushReplacementNamed(routes.LOGIN);
  }

  onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share(AppStrings.OPTIMUS_PRIME_MESSAGE,
        subject: AppStrings.SHARE_SUBJECT,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
