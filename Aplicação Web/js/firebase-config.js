import { initializeApp } from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";

import { getAuth } from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";

import { getFirestore } from
"https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";


const firebaseConfig = {

  apiKey: "AIzaSyAnrbsjFH4FiajDMHmXWVJtTA3IITQFSiY",

  authDomain: "doame-21717.firebaseapp.com",

  projectId: "doame-21717",

  storageBucket: "doame-21717.firebasestorage.app",

  messagingSenderId: "38594372187",

  appId: "1:38594372187:web:1ae2b1d08d9d2f5168157e"

};


const app = initializeApp(firebaseConfig);

export const auth = getAuth(app);

export const db = getFirestore(app);