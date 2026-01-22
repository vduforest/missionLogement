function sendDocument() {
  const fileInput = document.getElementById('preuveBourse');
  let radio = document.getElementById('ouiB');
  if (radio === null) {
    radio = document.getElementById('ouib');
  }
  if (radio.checked) {
    fileInput.style.display = "inline";
  } else {
    fileInput.style.display = "none";
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
  const parent = img.parentNode;
  if (imput.disabled) {
    imput.disabled = false;
    img.src = "img/open.png";
    parent.classList.remove("btn-secondary");
    parent.classList.add("btn-success");
  } else {
    imput.disabled = true;
    img.src = "img/close.png";
    parent.classList.add("btn-secondary");
    parent.classList.remove("btn-success");
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

function openForm(id) {
  var formVE = document.getElementById(id);
  openRecursive(formVE);
}

function message() {
  alert("Si vous voulez changer ces attributs veuillez appeler le numéro de la mission logement (voir informations standards)")
}
