
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/app_screens/add_user.dart';
import 'package:flutterfire_samples/app_screens/requests.dart';
import 'package:flutterfire_samples/screens/database/crud/db_add_screen.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AddUser()));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 70.0,
                        color: Colors.lightBlue,
                      ),
                      Text(
                        'Add user',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserRequests()));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.read_more,
                          size: 70.0, color: Colors.lightGreen),
                      Text(
                        'User Requests',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                   Navigator.push(
                       context, MaterialPageRoute(builder: (_) => DbAddScreen()));
                 },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.book,
                        size: 70.0,
                        color: Colors.lightBlue,
                      ),
                      Text(
                        'Add Advert',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
