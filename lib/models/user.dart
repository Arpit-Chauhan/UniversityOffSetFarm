import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String age;
  final String name;

  const User({
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.age,
    required this.name,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      age: snapshot["age"],
      name: snapshot['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "age": age,
        "name": name,
      };
}
