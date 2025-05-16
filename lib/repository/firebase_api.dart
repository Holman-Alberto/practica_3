import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  Future<String?> createUser(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String?> signInUser(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void recoveryPassword(String emailAddress) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
  }

  Future<bool> validateSession() async {
    //Devuelve true si no hay alguien loggeado
    return await FirebaseAuth.instance.currentUser == null;
  }
}
