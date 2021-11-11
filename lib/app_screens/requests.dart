import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRequests extends StatefulWidget {
  @override
  _UserRequestsState createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  //String variables to receive data

  String title = "";
  String request = "";

  bool isApproved = false;

  //instance of  document referrence
  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc('requests/myRequests');

  //streamsubscription

  StreamSubscription<DocumentSnapshot>? streamSubscription;

  //method to fetch data from firebase
  void fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          title = datasnapshot['title'];
          request = datasnapshot['request'];
        });
      }
    });
  }

  //overriding the initstate

  @override
  void initState() {
    super.initState();
    streamSubscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          title = datasnapshot['title'];
          request = datasnapshot['request'];
        });
      }
    });
  }

  //overriding the dispose method to dispose the subcription

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              fetch();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: title == null
                    ? Center(child: CircularProgressIndicator())
                    : ListTile(
                        trailing: RaisedButton(
                          onPressed: () {
                            setState(() {
                              isApproved = true;
                            });
                          },
                          child: isApproved
                              ? Text(
                                  'Approved',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                              : Text(
                                  'Approve',
                                  style: TextStyle(color: Colors.red),
                                ),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        subtitle: Text(
                          request,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
