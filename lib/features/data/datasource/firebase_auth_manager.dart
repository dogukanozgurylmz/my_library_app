import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthManager {
  late FirebaseAuth firebaseAuth;

  FirebaseAuthManager() {
    firebaseAuth = FirebaseAuth.instance;
  }
}
