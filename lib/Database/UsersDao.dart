
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_route/Database/model/User.dart';

class UsersDao {

  static CollectionReference<User> getUsersCollection(){
    // insert into firestore db
    var db = FirebaseFirestore.instance;
    var usersCollection = db.collection(User.collectionName).
    withConverter(
        fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
        toFirestore: (object, options) => object.toFirestore()
    );
    return usersCollection;
  }

 static Future<void> createUser(User user){
   var usersCollection = getUsersCollection();
   var doc = usersCollection.doc(user.id);   // create doc with uid (Authentication)
   return doc.set(user);
  }

  static Future<User?> getUser(String uid) async{
    var doc = getUsersCollection()
        .doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();

  }
}