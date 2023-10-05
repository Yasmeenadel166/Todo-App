import 'package:flutter/material.dart';
import '../Database/UsersDao.dart';
import '../Database/model/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  User? firebaseAuthUser;
  MyUser.User? databaseUser;

  Future<void> register(
      String email, String password, String userName, String fullName) async {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // insert user into database
    await UsersDao.createUser(MyUser.User(
        id: result.user?.uid,
        userName: userName,
        fullName: fullName,
        email: email));
  }

  Future<void> login(String email, String password) async {
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var user = await UsersDao.getUser(result.user!.uid); // get user from DB
    databaseUser = user;
    firebaseAuthUser = result.user;
  }

  void logout() {
    databaseUser = null;
    FirebaseAuth.instance.signOut();
  }

  bool isLoggedInBefore() {
    return FirebaseAuth.instance.currentUser !=null;
  }

  Future<void> retrieveUserFromDatabase() async{
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    databaseUser = await UsersDao.getUser(firebaseAuthUser!.uid);
  }
}