import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  //getting firestore instance
  FirebaseFirestore? firestore;

  //Global key for validation
  final formKey = GlobalKey<FormState>();

  //textEditing controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isLoading = false;
//method to subit data
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
      title: Text("User Data"),
      content: Text("User added"),
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

  void submit() async {
    UserCredential? result;
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance.collection("User").doc(result!.user!.uid).set({
      "UserName": nameController.text,
      "UserId": result.user!.uid,
      "UserEmail": emailController.text,
      "UserRole": roleController.text,
      "UserPass": passController.text,
    }).whenComplete(() {
      showAlertDialog(context);
    });
    setState(() {
      isLoading = false;
    });
  }

  //build method
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Value cannot be empty';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter user name',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cant be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value!)) {
                    return 'Please a valid Email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password cannot be empty";
                  }
                  if (value.length < 6) {
                    return "Password cannot be less than 6 characters";
                  }
                  return null;
                },
                controller: passController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'value cannot be empty';
                  }
                  return null;
                },
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Role',
                  hintText: 'Enter role here',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              //button tosubmit data
              RaisedButton(
                onPressed: submit,
                child: Text('Submit'),
                color: ThemeData().primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
