import 'package:flutter/material.dart';
import 'package:flutterfire_samples/app_screens/apply.dart';
import 'package:flutterfire_samples/app_screens/profilescreen.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';
import 'package:flutterfire_samples/services/usermanagement.dart';
import 'package:flutterfire_samples/widgets/app_bar_title.dart';
import 'package:flutterfire_samples/widgets/database/crud/db_item_list.dart';

import 'db_add_screen.dart';

class DbDashboardScreen extends StatefulWidget {
  @override
  _DbDashboardScreenState createState() => _DbDashboardScreenState();
}

class _DbDashboardScreenState extends State<DbDashboardScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          new Container(
            child: new DrawerHeader(
                child: new CircleAvatar(
              backgroundColor: Palette.firebaseNavy,
            )),
            color: Palette.firebaseNavy,
          ),
          Container(
            color: Colors.blueAccent,
            child: new Column(children: [
              new ListTile(
                  leading: new Icon(Icons.info),
                  title: Text("Admin Page"),
                  onTap: () {
                    Usermanagement().authorizeAccess(context);
                  }),
              ListTile(
                  leading: new Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatSettings()));
                  })
            ]),
          )
        ],
      )),
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'BrandAmbassador',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Apply(),
            ),
          );
        },
        backgroundColor: Palette.firebaseOrange,
        child: Text("Apply")
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: DbItemList(),
        ),
      ),
    );
  }
}
