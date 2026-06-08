class HemocentroModel{

final String nome;

final String cidade;

final Map<String,dynamic> estoque;

HemocentroModel({

required this.nome,

required this.cidade,

required this.estoque,

});

factory HemocentroModel.fromMap(

Map<String,dynamic> map

){

return HemocentroModel(

nome:

map["nome"] ?? "",

cidade:

map["cidade"] ?? "",

estoque:

map["estoque"] ?? {},

);

}

}