import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
 Future<void> logInWithGoogle() async {
    try {
      var _firebaseAuth =  FirebaseAuth.instance;
      var _googleSignIn = GoogleSignIn.standard();
      
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on Exception catch(error) {
      //throw LogInWithGoogleFailure();
      print('erro');
    }
  }
}