import 'package:flutter/material.dart';

import '../widgets/hexagon_painter.dart';

import 'menu_view.dart';

class RegiaoView extends StatefulWidget {

const RegiaoView({

super.key,

});

@override

State<RegiaoView> createState()

=>

_RegiaoViewState();

}

class _RegiaoViewState

extends State<RegiaoView>{

String?

regiaoSelecionada;

final regioes=[

"Salvador",

"Feira de Santana",

];

@override

Widget build(

BuildContext context

){

return Scaffold(

backgroundColor:

const Color(
0xFFFDE2E4
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

Center(

child:

Padding(

padding:

const EdgeInsets.all(
30,
),

child:

Column(

mainAxisAlignment:

MainAxisAlignment.center,

children:[

const Icon(

Icons.water_drop,

size:60,

color:

Color(
0xFFE13D3D,
),

),

const SizedBox(

height:15,

),

const Text(

"DOA.ME",

style:

TextStyle(

fontSize:32,

fontWeight:

FontWeight.bold,

color:

Color(
0xFFE13D3D,
),

),

),

const SizedBox(

height:50,

),

const Text(

"Selecione sua região",

style:

TextStyle(

fontSize:20,

fontWeight:

FontWeight.bold,

),

),

const SizedBox(

height:25,

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
0xFFF2F2F2
),

borderRadius:

BorderRadius.circular(
30,
),

border:

Border.all(

color:

Colors.black,

),

),

child:

DropdownButtonHideUnderline(

child:

DropdownButton<String>(

value:

regiaoSelecionada,

hint:

const Text(

"Escolha uma região",

),

isExpanded:true,

items:

regioes.map(

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

regiaoSelecionada=v;

});

},

),

),

),

const SizedBox(

height:40,

),

ElevatedButton(

onPressed:

regiaoSelecionada==null

?

null

:

(){

Navigator.pushReplacement(

context,

MaterialPageRoute(

builder:

(_)

=>

MenuView(

regiao:

regiaoSelecionada!,

),

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

padding:

const EdgeInsets.symmetric(

horizontal:50,

vertical:16,

),

),

child:

const Text(

"CONFIRMAR",

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