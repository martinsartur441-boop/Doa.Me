import { auth, db }

from "./firebase-config.js";

import {

createUserWithEmailAndPassword

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";

import {

doc,
setDoc

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";


const form =
document.getElementById(
"cadastroForm"
);


form.addEventListener(

"submit",

async (event)=>{

event.preventDefault();


const nome =
document.getElementById(
"nome"
).value;

const email =
document.getElementById(
"email"
).value;

const cidade =
document.getElementById(
"cidade"
).value;

const estado =
document.getElementById(
"estado"
).value;

const senha =
document.getElementById(
"senha"
).value;

const confirmarSenha =
document.getElementById(
"confirmarSenha"
).value;



if(
senha !== confirmarSenha
){

alert(
"As senhas não coincidem"
);

return;

}



try{

const credencial =

await createUserWithEmailAndPassword(

auth,

email,

senha

);

const usuario =
credencial.user;


await setDoc(

doc(
db,
"hemocentros",
usuario.uid
),

{

nome,

email,

cidade,

estado,

estoque:{

"A+":0,

"A-":0,

"B+":0,

"B-":0,

"AB+":0,

"AB-":0,

"O+":0,

"O-":0

}

}

);


alert(
"Cadastro realizado!"
);


window.location.href =
"index.html";


}

catch(error){

console.log(error);

alert(
error.message
);

}

});