import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User> get user => auth.authStateChanges();

  Future<User> createAccount({String email, String password}) async {
    try {
      UserCredential _userCredential =
          await auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      // return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      UserCredential _userCredential =
          await auth.signInWithCredential(credential);
      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      // return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}
