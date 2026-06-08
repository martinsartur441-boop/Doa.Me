import 'package:cloud_firestore/cloud_firestore.dart';

class HemocentroViewModel {

  final firestore = FirebaseFirestore.instance;

  Future<Map<String,int>>

  buscarEstoqueRegional(

    String regiao,

  )

  async{

    try{

      final snapshot =

      await firestore

      .collection(

        "hemocentros",

      )

      .where(

        "cidade",

        isEqualTo: regiao,

      )

      .get();

      Map<String,int> soma = {};

      for(

        final doc

        in

        snapshot.docs

      ){

        final dados = doc.data();

        if(

          !dados.containsKey(

            "estoque",

          )

        ){

          continue;

        }

        final estoque =

        Map<String,dynamic>.from(

          dados["estoque"],

        );

        estoque.forEach(

          (

            tipo,

            valor,

          ){

            soma[tipo] =

            (

              soma[tipo]

              ??

              0

            )

            +

            (

              valor as num

            ).toInt();

          },

        );

      }

      return soma;

    }

    catch(e){

      throw Exception(

        "Erro ao carregar estoques: $e",

      );

    }

  }

}