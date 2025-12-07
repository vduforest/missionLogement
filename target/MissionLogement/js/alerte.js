/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function afficherTexte(estBoursier, estPmr, genre, genreInitial){
    let texte="";
    if (estBoursier){
        texte+="Bourse à vérifier;\n";
    }
    if (estPmr){
        texte+="A besoin de dispositions particulières;\n";
    }
    if (genre !== genreInitial){
        texte+="Changement de genre;\n";
    }
    alert(texte);
}

