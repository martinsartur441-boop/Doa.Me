import 'package:flutter/material.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../widgets/hexagon_painter.dart';
import '../widgets/input_decoration.dart';
import '../widgets/motivacao_card.dart';

import 'cadastro_view.dart';
import 'regiao_view.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final _emailController =
      TextEditingController();

  final _senhaController =
      TextEditingController();

  final auth =
      AuthViewModel();

  bool carregando =
      false;

  Future<void> _entrar() async {

    try {

      setState(() {

        carregando = true;

      });

      await auth.login(

        email:
        _emailController.text.trim(),

        senha:
        _senhaController.text,

      );

      if(!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder:
          (_)
          =>
          const RegiaoView(),

        ),
 
      );

    }

    catch(e){

      if(!mounted) return;

      showDialog(

        context: context,

        builder:
        (_)
        =>
        AlertDialog(

          shape:

          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(20),

          ),

          title:

          const Text(

            "Acesso negado",

            style:

            TextStyle(

              color:
              Color(0xFFE13D3D),

              fontWeight:
              FontWeight.bold,

            ),

          ),

          content:

          Text(

            e.toString(),

          ),

          actions:[

            TextButton(

              onPressed:
              (){

                Navigator.pop(context);

              },

              child:

              const Text(

                "Tentar novamente",

                style:

                TextStyle(

                  color:
                  Color(0xFFE13D3D),

                ),

              ),

            ),

            ElevatedButton(

              onPressed:
              (){

                Navigator.pop(context);

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:

                    (_)

                    =>

                    const CadastroView(),

                  ),

                );

              },

              style:

              ElevatedButton.styleFrom(

                backgroundColor:

                const Color(
                  0xFFE13D3D,
                ),

                foregroundColor:

                Colors.white,

                shape:

                RoundedRectangleBorder(

                  borderRadius:

                  BorderRadius.circular(
                    20,
                  ),

                ),

              ),

              child:

              const Text(
                "Cadastrar-se",
              ),

            )

          ],

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

    _emailController.dispose();

    _senhaController.dispose();

    super.dispose();

  }

  @override

  Widget build(
    BuildContext context,
  ){

    return Scaffold(

      backgroundColor:

      const Color(
        0xFFFDE2E4,
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

                    height:80,

                  ),

                  const Icon(

                    Icons.water_drop,

                    color:

                    Color(
                      0xFFE13D3D,
                    ),

                    size:60,

                  ),

                  const Text(

                    "DOA.ME",

                    style:

                    TextStyle(

                      color:

                      Color(
                        0xFFE13D3D,
                      ),

                      fontSize:32,

                      fontWeight:

                      FontWeight.bold,

                      letterSpacing:2,

                    ),

                  ),

                  const SizedBox(

                    height:50,

                  ),

                  TextField(

                    controller:

                    _emailController,

                    keyboardType:

                    TextInputType.emailAddress,

                    decoration:

                    inputDecoration(
                      "E-mail",
                    ),

                  ),

                  const SizedBox(

                    height:15,

                  ),

                  TextField(

                    controller:

                    _senhaController,

                    obscureText:true,

                    decoration:

                    inputDecoration(
                      "Senha",
                    ),

                  ),

                  const SizedBox(

                    height:30,

                  ),

                  ElevatedButton(

                    onPressed:

                    carregando

                    ?

                    null

                    :

                    _entrar,

                    style:

                    ElevatedButton.styleFrom(

                      backgroundColor:

                      const Color(
                        0xFFE13D3D,
                      ),

                      foregroundColor:

                      Colors.white,

                      minimumSize:

                      const Size(

                        double.infinity,

                        55,

                      ),

                      shape:

                      RoundedRectangleBorder(

                        borderRadius:

                        BorderRadius.circular(
                          30,
                        ),

                      ),

                    ),

                    child:

                    carregando

                    ?

                    const SizedBox(

                      width:22,

                      height:22,

                      child:

                      CircularProgressIndicator(

                        color:

                        Colors.white,

                        strokeWidth:3,

                      ),

                    )

                    :

                    const Text(

                      "ENTRAR",

                      style:

                      TextStyle(

                        fontWeight:

                        FontWeight.bold,

                      ),

                    ),

                  ),

                  const SizedBox(

                    height:20,

                  ),

                  TextButton(

                    onPressed:

                    (){

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder:

                          (_)

                          =>

                          const CadastroView(),

                        ),

                      );

                    },

                    child:

                    const Text(

                      "Não tem uma conta? Cadastre-se",

                      style:

                      TextStyle(

                        color:

                        Color(
                          0xFFE13D3D,
                        ),

                        fontWeight:

                        FontWeight.bold,

                      ),

                    ),

                  ),

                  const SizedBox(

                    height:20,

                  ),

                  const MotivacaoCard(),

                  const SizedBox(

                    height:40,

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