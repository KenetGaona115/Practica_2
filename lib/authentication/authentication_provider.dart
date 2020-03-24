import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get getFirebaseAuth => _auth;

  Future<bool> userAlreadyLogged() async {
    return await _auth.currentUser() != null;
  }

  Future<void> logOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print(">>> googleAuth: $googleAuth");
    print(">>> googleUserId: ${googleUser.id}");
    print(">>> googleUserName: ${googleUser.displayName}");
    print(">>> googleUserEmail: ${googleUser.email}");
    print(">>> googleUserPhoto: ${googleUser.photoUrl}");
  }
}
