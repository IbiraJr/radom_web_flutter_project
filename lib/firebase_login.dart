import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogin {
  FirebaseAuth auth;


  Future<UserCredential> login(String login, String password) async {
    auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try {
       userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: login,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return userCredential;

  }
}
