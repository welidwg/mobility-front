import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseUtils{
   static final FirebaseAuth _auth = FirebaseAuth.instance;
   static final GoogleSignIn _googleSignIn = GoogleSignIn();
   static final FirebaseFirestore _fireStore=FirebaseFirestore.instance;

   static Future storeUser(User? user,Map<String,dynamic> data)async{
     if(user!=null){
       await _fireStore.collection('users').doc(user.uid).set({
         'name': data["name"],
         'surname': data["surname"],
         'email': user.email,
         'photoURL': user.photoURL,
         'lastSignInTime': user.metadata.lastSignInTime,
         'age': data["age"],
         'gender':data["gender"]
       });
     }
   }

   static Future<bool> checkUserExisting(User? user)async{
     bool existing=false;
     final DocumentSnapshot userDoc = await _fireStore.collection('users').doc(user!.uid).get();
     if(userDoc.exists){
       existing=true;
     }
     return existing;
   }

   static FirebaseAuth getAuthInstance(){
     return _auth;
   }

   static Future logout()async{
     await _auth.signOut();
     await  _googleSignIn.signOut();
   }


   static Future verifyAuth()async{
     User? user= _auth.currentUser;
     if(user==null){
       return null;
     }
     return user;
   }
  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // L'utilisateur a annulé la connexion
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      return user;
    } catch (e) {
      print("errrorrr : $e");
      return null;
    }
  }

}