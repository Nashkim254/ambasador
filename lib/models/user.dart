import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String? id;
  String? photoUrl;
  String? nickname;
  String? aboutMe;

  UserChat({required this.id, required this.photoUrl, required this.nickname, required this.aboutMe});


}
Future<UserChat> getImagePostFromDocument(DocumentSnapshot document) async {
  DocumentReference userReference = document['user'];
  DocumentSnapshot userRef = await userReference.get();
  // User userInfo = User.fromJSON(userRef);
  UserChat post = new UserChat(
    id: document.id,
    aboutMe: document['aboutMe'],
    photoUrl: document['photoUrl'],
    nickname: document['nickname'],
  );
  return post;
}