import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/res/custom_colors.dart';

class Apply extends StatelessWidget {
   Apply({Key? key}) : super(key: key);

  TextEditingController locController = TextEditingController();
  TextEditingController reqController = TextEditingController();
  String? userUid;

  void getUserUid() {
    User? myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser!.uid;
  }


  @override
  Widget build(BuildContext context) {

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
      title: Text("Request sent"),
      content: Text("We are working on the request"),
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

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("requests/myRequests");
  void send() {
    Map<String, String> reqdata = <String, String>{
      "title": locController.text,
      "request": reqController.text,
    };
    documentReference.set(reqdata).whenComplete(() {
      print('Data added');
      showAlertDialog(context);
    });
  }
    return Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(title: Text("Apply for Advert")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: locController,
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Title",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
              ),
            
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
                  cursorColor: Colors.black,
                  controller: reqController,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.local_taxi,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Description",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                ),
                onPressed: () {
                  send();
                },
              ),
            ),
            ],
          ),
        ));
  }
}
