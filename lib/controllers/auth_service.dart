import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Buat amkun pakai email&pass method
  Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Amkun dibuat";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Login pakai email dan pass
  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login anda berhasil";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // Logout
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Cek jikalau user sudah punya akun atau belum
  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // Loggin pakai akun gugel anda
  Future<String> continueWithGoogle() async {
    try {
      // Kirim Auth request
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await googleUser!.authentication;

      // Ambil kredensial
      final creds = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      // Baru login pakai kredensial tdi
      await FirebaseAuth.instance.signInWithCredential(creds);

      return "Google login";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
