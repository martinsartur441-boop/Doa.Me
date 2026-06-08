import {

auth,
db

}

from "./firebase-config.js";


import {

doc,
updateDoc

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";


import {

signOut,
onAuthStateChanged

}

from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";



const form =
document.getElementById(
"estoqueForm"
);


const logoutBtn =
document.getElementById(
"logoutBtn"
);



/* VERIFICA LOGIN */

onAuthStateChanged(

auth,

(user)=>{

if(!user){

window.location.href =
"login.html";

}

}

);



/* SALVAR ESTOQUE */

form.addEventListener(

"submit",

async(e)=>{

e.preventDefault();

const user =
auth.currentUser;

if(!user){

alert(
"Faça login"
);

return;

}

try{

await updateDoc(

doc(
db,
"hemocentros",
user.uid
),

{

estoque:{

"A+":
Number(
document.getElementById(
"Aplus"
).value
),

"A-":
Number(
document.getElementById(
"Aminus"
).value
),

"B+":
Number(
document.getElementById(
"Bplus"
).value
),

"B-":
Number(
document.getElementById(
"Bminus"
).value
),

"AB+":
Number(
document.getElementById(
"ABplus"
).value
),

"AB-":
Number(
document.getElementById(
"ABminus"
).value
),

"O+":
Number(
document.getElementById(
"Oplus"
).value
),

"O-":
Number(
document.getElementById(
"Ominus"
).value
)

}

}

);

alert(
"Estoque atualizado!"
);

/* opcional */
// window.location.href="index.html";

}

catch(error){

console.log(error);

alert(
"Erro ao salvar"
);

}

});



/* LOGOUT */

logoutBtn.addEventListener(

"click",

async()=>{

await signOut(auth);

window.location.href =
"index.html";

}

);