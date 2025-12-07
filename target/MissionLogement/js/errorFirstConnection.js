/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */

function error(bool){
    console.log(bool);
    if(bool===true){
        element=document.getElementById("form");
        text=document.createElement("p");
        text.textContent="Erreur : vérifiez que le numéro SCEI est le bon et vérifiez que la confirmation du mot de passe est identique au mot de passe. Sinon changez d'identifiants";
        text.textContent+=" Vous ne pouvez créer qu'une seule fois un login/mot de passe";
        element.appendChild(text);
    }
}

