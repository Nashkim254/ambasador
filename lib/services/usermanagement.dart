import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_samples/app_screens/admin_page.dart';
import 'package:flutterfire_samples/app_screens/login.dart';
import 'package:flutterfire_samples/screens/authentication/email_password/ep_sign_in_screen.dart';
import 'package:flutterfire_samples/screens/database/crud/db_add_screen.dart';
import 'package:flutterfire_samples/screens/database/crud/db_dashboard_screen.dart';
import 'package:flutterfire_samples/screens/database/crud/db_edit_screen.dart';
import 'package:flutterfire_samples/screens/database/crud/db_login_screen.dart';
import 'package:flutterfire_samples/screens/main_screens/home_screen.dart';
import 'package:flutterfire_samples/widgets/authentication/email_password/ep_sign_in_form.dart';

class Usermanagement {
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DbDashboardScreen();
        } else {
          return EPSignInForm();
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Not autherized! You are not an admin!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  authorizeAccess(BuildContext context) {
    var user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('User')
        .where('UserId', isEqualTo: user!.uid)
        .get()
        .then((mydocs) {
      if (mydocs.docs[0].exists) {
        if (mydocs.docs[0].data()['UserRole'] == 'admin') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => 
              AdminPage(),
            ),
          );
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => AdminPage()));
        } else {
          showAlertDialog(context);
        }
      }
    });
  }

  authorizeEditAccess(
      BuildContext context, String title, String description, String docID) {
    var user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('User')
        .where('UserId', isEqualTo: user!.uid)
        .get()
        .then((mydocs) {
      if (mydocs.docs[0].exists) {
        if (mydocs.docs[0].data()['UserRole'] == 'admin') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DbEditScreen(
                currentTitle: title,
                currentDescription: description,
                documentId: docID,
              ),
            ),
          );
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => AdminPage()));
        } else {
          showAlertDialog(context);
        }
      }
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
