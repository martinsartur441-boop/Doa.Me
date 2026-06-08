import { db }

from "./firebase-config.js";


import {

collection,
getDocs

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";


const container =
document.getElementById(
"regioes"
);


async function carregar(){

const snapshot =

await getDocs(

collection(
db,
"hemocentros"
)

);


const regioes = {};


snapshot.forEach((doc)=>{

const dados =
doc.data();

const chave =
dados.cidade +
" - " +
dados.estado;


if(!regioes[chave]){

regioes[chave]={

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

dados.estoque

){

regioes[chave][tipo]+=

dados.estoque[tipo];

}

});


render(regioes);

}


function render(regioes){

container.innerHTML="";


for(

const cidade

in

regioes

){

let html="";

for(

const tipo

in

regioes[cidade]

){

html += `

<div class="card">

<h3>${tipo}</h3>

<p>

${regioes[cidade][tipo]}

</p>

</div>

`;

}


container.innerHTML += `

<div class="regiao">

<h2>

${cidade}

</h2>

<div class="grid">

${html}

</div>

</div>

`;

}

}


carregar();