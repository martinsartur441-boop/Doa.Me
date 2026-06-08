import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

final FirebaseAuth _auth=

FirebaseAuth.instance;

Future<UserCredential> cadastrar({

required String email,

required String senha,

}) async{

return await _auth

.createUserWithEmailAndPassword(

email: email,

password: senha,

);

}

Future<UserCredential> login({

required String email,

required String senha,

}) async{

return await _auth

.signInWithEmailAndPassword(

email: email,

password: senha,

);

}

Future logout() async{

await _auth.signOut();

}

}