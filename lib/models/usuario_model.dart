class UsuarioModel {

final String uid;

final String nome;

final String email;

final String tipoSanguineo;

UsuarioModel({

required this.uid,

required this.nome,

required this.email,

required this.tipoSanguineo,

});

Map<String,dynamic> toMap(){

return {

'uid':uid,

'nome':nome,

'email':email,

'tipoSanguineo':tipoSanguineo,

};

}

factory UsuarioModel.fromMap(

Map<String,dynamic> map

){

return UsuarioModel(

uid: map['uid'],

nome: map['nome'],

email: map['email'],

tipoSanguineo: map['tipoSanguineo'],

);

}

}