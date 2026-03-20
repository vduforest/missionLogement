function sendDocument() {
  const fileInput = document.getElementById('preuveBourse');
  let radio = document.getElementById('ouiB');
  if (radio === null) {
    radio = document.getElementById('ouib');
  }

  if (!fileInput || !radio) {
    return;
  }

  if (radio.checked) {
    fileInput.style.display = "inline";
  } else {
    fileInput.style.display = "none";
    fileInput.value = "";
    fileInput.removeAttribute("required");
  }
}
function verifMail(id1, id2) {
  let mail1 = document.getElementById(id1);
  let mail2 = document.getElementById(id2);
  if (mail1.value !== mail2.value) {
    mail2.setCustomValidity("Les adresses mail ne correspondent pas.");
    mail2.style.borderColor = "red";
  } else {
    mail2.setCustomValidity("");
    mail2.style.borderColor = "green";
  }
}

function delock(id) {
  const img = document.getElementById('img_' + id);
  const imput = document.getElementById(id);
  const parent = img.closest('.btn');
  const textSpan = document.getElementById('text_locker_' + id);

  if (imput.disabled) {
    // Unlock action
    imput.disabled = false;
    img.src = "img/open.png";
    parent.classList.remove("btn-outline-dark", "btn-secondary");
    parent.classList.add("btn-success");

    if (textSpan) textSpan.innerText = "Déverrouillé";
  } else {
    // Lock action
    imput.disabled = true;
    img.src = "img/close.png";
    parent.classList.remove("btn-success");
    parent.classList.add("btn-outline-dark");

    if (textSpan) textSpan.innerText = "Verrouillé";
  }
}

function openChamp(id) {
  const img = document.getElementById('img_' + id);
  const imput = document.getElementById(id);
  if (imput.disabled) {
    imput.disabled = false;
    img.src = "img/open.png";
  }
}

function openRecursive(anyRef) {
  if ((anyRef !== null) && (anyRef !== undefined)) {
    var elt = anyRef.firstChild;
    while (elt !== null) {
      if (elt.nodeType === 1) { // Element Node
        if (elt.hasAttribute("disabled")) {
          elt.disabled = false;
        }
        openRecursive(elt);
      }
      elt = elt.nextSibling;
    }
  }
}

function confirmerEtOuvrir(id,entier) {
    
    entier = parseInt(entier);
    let txt = "";
    // Ecriture du texte de la box
    if (entier === 1){
        txt = "Vous allez envoyer un mail de réinitialisation de mot de passe, voulez-vous continuer ?";
    } else if (entier === 2){
        txt = "Vous allez enregistrer le formulaire, voulez-vous continuer ?";
    } else if (entier === 3){
        txt = "Vous allez valider le formulaire, vous ne pourrez plus y toucher ensuite, voulez-vous continuer ?";
    }else if (entier === 4){
        txt = "Vous allez refuser le formulaire, l'élève va recevoir un mail lui expliquant pourquoi, voulez-vous continuer ?";
    }
    
    if (confirm(txt)) {
        if (entier === 4){
            if (!messageCommVide(id)){
                return false;
            }
        }
        openForm(id);
        return true;
    }
    return false;
}

function openForm(id) {
  var formVE = document.getElementById(id);
  openRecursive(formVE);
}

function messageCommVide(id) {
  /*
   * var commentaireDiv = document.getElementById("commentairesVeDiv");
  var commLabel = commentaireDiv.firstElementChild;
  var commentaire = commLabel.nextElementSibling;
  const comm = commentaire.textContent;
   */
  const comm = document.getElementById("commentairesVe").textContent;
  if ((comm === null) || (comm.trim() === "")) {
    alert("Vous ne pouvez pas refuser un dossier sans expliquer la raison, veuillez remplir la case de commentaires à transmettre au candidat.");
    return false;
  }
  else{
    return true;
  }
}

function message() {
  alert("Si vous voulez changer ces attributs veuillez appeler le numéro de la mission logement (voir informations standards)")
}
