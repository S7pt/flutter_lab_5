import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/models/auth_person.dart';
import 'package:to_do_list/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Person? currentUser;
  Person? _personFromFirebaseUser(User? user) {
    return user != null ? Person(uid: user.uid) : null;
  }

  Stream<Person?> get user {
    return _auth.authStateChanges().map(_personFromFirebaseUser);
  }

  // sign in with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      currentUser = _personFromFirebaseUser(user);
      return currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updatePersonData('Name', '');
      currentUser = _personFromFirebaseUser(user);
      return currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
