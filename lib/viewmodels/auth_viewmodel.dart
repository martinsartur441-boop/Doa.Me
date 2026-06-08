import

'package:firebase_auth/firebase_auth.dart';

import '../models/usuario_model.dart';

import '../services/auth_service.dart';

import '../services/firestore_service.dart';

class AuthViewModel{

final AuthService auth=

AuthService();

final FirestoreService firestore=

FirestoreService();

Future cadastrar({

required String nome,

required String email,

required String senha,

required String tipo,

}) async{

UserCredential cred=

await auth.cadastrar(

email: email,

senha: senha,

);

UsuarioModel usuario=

UsuarioModel(

uid:

cred.user!.uid,

nome:nome,

email:email,

tipoSanguineo:tipo,

);

await firestore

.salvarUsuario(

usuario

);

}

Future login({

required String email,

required String senha,

}) async{

await auth.login(

email: email,

senha: senha,

);

}

}