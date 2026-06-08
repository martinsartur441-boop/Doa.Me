import 'package:flutter/material.dart';

import '../viewmodels/auth_viewmodel.dart';

import '../widgets/input_decoration.dart';
import '../widgets/hexagon_painter.dart';

class CadastroView extends StatefulWidget {

  const CadastroView({super.key});

  @override
  State<CadastroView> createState()
  =>
  _CadastroViewState();

}

class _CadastroViewState
extends State<CadastroView>{

  final nomeController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final senhaController =
  TextEditingController();

  final auth =
  AuthViewModel();

  bool carregando=false;

  final List<String>
  tiposSanguineos=[

    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',

  ];

  String?
  tipoSelecionado;

  Future cadastrar() async{

    if(

      tipoSelecionado==null

    ){

      ScaffoldMessenger.of(context)

      .showSnackBar(

        const SnackBar(

          content:

          Text(
            "Selecione o tipo sanguíneo",
          ),

        ),

      );

      return;

    }

    try{

      setState(() {

        carregando=true;

      });

      await auth.cadastrar(

        nome:

        nomeController.text.trim(),

        email:

        emailController.text.trim(),

        senha:

        senhaController.text,

        tipo:

        tipoSelecionado!,

      );

      if(!mounted) return;

      showDialog(

        context: context,

        builder:

        (_)

        =>

        AlertDialog(

          title:

          const Text(

            "Cadastro realizado",

          ),

          content:

          const Text(

            "Conta criada com sucesso",

          ),

          actions:[

            ElevatedButton(

              onPressed:(){

                Navigator.pop(context);

                Navigator.pop(context);

              },

              child:

              const Text(

                "Ir Login",

              ),

            )

          ],

        ),

      );

    }

    catch(e){

      if(!mounted) return;

      ScaffoldMessenger.of(context)

      .showSnackBar(

        SnackBar(

          content:

          Text(

            e.toString(),

          ),

        ),

      );

    }

    if(mounted){

      setState(() {

        carregando=false;

      });

    }

  }

  @override

  void dispose(){

    nomeController.dispose();

    emailController.dispose();

    senhaController.dispose();

    super.dispose();

  }

  @override

  Widget build(
    BuildContext context
  ){

    return Scaffold(

      backgroundColor:

      const Color(
        0xFFFDE2E4,
      ),

      appBar:

      AppBar(

        backgroundColor:

        Colors.transparent,

        elevation:0,

        leading:

        const BackButton(

          color:

          Color(
            0xFFE13D3D,
          ),

        ),

      ),

      body:

      Stack(

        children:[

          Positioned.fill(

            child:

            CustomPaint(

              painter:

              HexagonPainter(),

            ),

          ),

          SafeArea(

            child:

            SingleChildScrollView(

              padding:

              const EdgeInsets.symmetric(

                horizontal:30,

              ),

              child:

              Column(

                children:[

                  const SizedBox(

                    height:20,

                  ),

                  const Text(

                    "CADASTRAR",

                    style:

                    TextStyle(

                      color:

                      Color(
                        0xFFE13D3D,
                      ),

                      fontWeight:

                      FontWeight.bold,

                      fontSize:24,

                    ),

                  ),

                  const SizedBox(

                    height:30,

                  ),

                  TextField(

                    controller:

                    nomeController,

                    decoration:

                    inputDecoration(

                      "Nome",

                    ),

                  ),

                  const SizedBox(
                    height:15,
                  ),

                  TextField(

                    controller:

                    emailController,

                    decoration:

                    inputDecoration(

                      "Email",

                    ),

                  ),

                  const SizedBox(
                    height:15,
                  ),

                  Container(

                    padding:

                    const EdgeInsets.symmetric(

                      horizontal:20,

                    ),

                    decoration:

                    BoxDecoration(

                      color:

                      const Color(
                        0xFFF2F2F2,
                      ),

                      borderRadius:

                      BorderRadius.circular(
                        30,
                      ),

                    ),

                    child:

                    DropdownButtonHideUnderline(

                      child:

                      DropdownButton(

                        value:

                        tipoSelecionado,

                        hint:

                        const Text(

                          "Tipo sanguíneo",

                        ),

                        isExpanded:true,

                        items:

                        tiposSanguineos.map(

                          (e){

                            return DropdownMenuItem(

                              value:e,

                              child:

                              Text(e),

                            );

                          },

                        ).toList(),

                        onChanged:(v){

                          setState(() {

                            tipoSelecionado=v;

                          });

                        },

                      ),

                    ),

                  ),

                  const SizedBox(
                    height:15,
                  ),

                  TextField(

                    controller:

                    senhaController,

                    obscureText:true,

                    decoration:

                    inputDecoration(

                      "Senha",

                    ),

                  ),

                  const SizedBox(
                    height:40,
                  ),

                  ElevatedButton(

                    onPressed:

                    carregando

                    ?

                    null

                    :

                    cadastrar,

                    style:

                    ElevatedButton.styleFrom(

                      backgroundColor:

                      const Color(
                        0xFFE13D3D,
                      ),

                      foregroundColor:

                      Colors.white,

                    ),

                    child:

                    carregando

                    ?

                    const CircularProgressIndicator(

                      color:

                      Colors.white,

                    )

                    :

                    const Text(

                      "CADASTRAR",

                    ),

                  )

                ],

              ),

            ),

          ),

        ],

      ),

    );

  }

}