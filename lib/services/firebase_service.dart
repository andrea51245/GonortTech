import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List>getUsers() async{
  List Users = [];
  CollectionReference collectionReferenceUsers = db.collection('Users');
  
  QuerySnapshot queryUsers = await collectionReferenceUsers.get();
  

  for (var documento in queryUsers.docs) {
    Users.add(documento.data());
  }
  return Users;
}

