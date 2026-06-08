import { db }

from "./firebase-config.js";

import {

collection,
getDocs

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";


const bloodGrid =
document.getElementById(
"bloodGrid"
);

const titulo =
document.getElementById(
"cidadeTitulo"
);

let cidades=[];

let slideAtual=0;



async function carregarEstoques(){

const snapshot=

await getDocs(

collection(
db,
"hemocentros"
)

);

const agrupado={};


snapshot.forEach((doc)=>{

const data=
doc.data();


const cidade=
data.cidade;


if(

!agrupado[cidade]

){

agrupado[cidade]={

"A+":0,
"A-":0,

"B+":0,
"B-":0,

"AB+":0,
"AB-":0,

"O+":0,
"O-":0

};

}


for(

const tipo

in

data.estoque

){

agrupado[cidade][tipo]+=

Number(

data.estoque[tipo]

);

}

});


cidades=

Object.entries(
agrupado
);

renderizar();

}



function renderizar(){

if(

cidades.length===0

){

titulo.innerText=

"Sem dados";

return;

}

bloodGrid.innerHTML="";


const [

cidade,
estoque

]

=

cidades[
slideAtual
];


titulo.innerText=

cidade;


for(

const tipo

in

estoque

){

bloodGrid.innerHTML+=`

<div class="blood-card">

<h3>

${tipo}

</h3>

<span>

${estoque[tipo]} bolsas

</span>

</div>

`;

}

}



window.proximoSlide=function(){

slideAtual++;

if(

slideAtual>=
cidades.length

){

slideAtual=0;

}

renderizar();

}



window.voltarSlide=function(){

slideAtual--;

if(

slideAtual<0

){

slideAtual=

cidades.length-1;

}

renderizar();

}



setInterval(()=>{

if(

cidades.length>1

){

window.proximoSlide();

}

},5000);



carregarEstoques();