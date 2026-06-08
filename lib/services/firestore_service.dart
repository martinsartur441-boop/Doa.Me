import

'package:cloud_firestore/cloud_firestore.dart';

import

'../models/usuario_model.dart';

class FirestoreService{

final FirebaseFirestore _db=

FirebaseFirestore.instance;

Future salvarUsuario(

UsuarioModel usuario

) async{

await _db

.collection(

'usuarios'

)

.doc(

usuario.uid

)

.set(

usuario.toMap()

);

}

}