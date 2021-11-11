import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_samples/models/user_model.dart';

class ProductProvider with ChangeNotifier {
  List<UserModel> userModelList = [];
  UserModel? userModel;
   
  Future<void> getUserData(DocumentSnapshot document) async {
     List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
  DocumentReference userReference = document['User'];
  QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
  // User userInfo = User.fromJSON(userRef);
 
  userSnapShot.docs .forEach((element){
     if(currentUser!.uid == document['UserId']) {
  userModel = new UserModel(
    userAddress: document['userAddress'],
     userEmail: document['userEmail'],
      userGender: document['userGender'], 
      userImage: document['userImage'], 
      userName:document['userName'], 
      userPhoneNumber: document['userPhoneNumber']  
 
  );
  newList.add(userModel!);
  }
  userModelList = newList;
        notifyListeners();
}
        
  );  
  }



  List<UserModel> get getUserModelList {
    return userModelList;
  }
}