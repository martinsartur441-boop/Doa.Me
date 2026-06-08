import { auth }

from "./firebase-config.js";

import {

signInWithEmailAndPassword

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";


const form =
document.getElementById(
"loginForm"
);


form.addEventListener(

"submit",

async(e)=>{

e.preventDefault();

const email =
document.getElementById(
"email"
).value;

const senha =
document.getElementById(
"senha"
).value;


try{

await signInWithEmailAndPassword(

auth,

email,

senha

);

window.location.href =
"estoque.html";

}

catch(error){

alert(
"Email ou senha inválidos"
);

console.log(error);

}

});