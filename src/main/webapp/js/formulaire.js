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

function openForm(id) {
  const form = document.getElementById(id);
  if (!form) return;

  // Clear previous hidden submit fixes to avoid duplicates
  form.querySelectorAll('.hidden-submit-fix').forEach(el => el.remove());

  // Find all disabled inputs/selects/textareas with a name
  const disabledElements = form.querySelectorAll('input[disabled][name], select[disabled][name], textarea[disabled][name]');
  disabledElements.forEach(elt => {
    // For checkboxes and radios, only submit if they are checked
    if ((elt.type === 'checkbox' || elt.type === 'radio') && !elt.checked) {
      return;
    }

    const hidden = document.createElement('input');
    hidden.type = 'hidden';
    hidden.name = elt.name;
    hidden.value = elt.value;
    hidden.classList.add('hidden-submit-fix');
    form.appendChild(hidden);
  });
}

function saveScrollPosition(pageKey) {
  localStorage.setItem(pageKey + "ScrollPos", window.scrollY);
}

function restoreScrollPosition(pageKey) {
  const scrollPos = localStorage.getItem(pageKey + "ScrollPos");
  if (scrollPos) {
    window.scrollTo(0, parseInt(scrollPos));
    localStorage.removeItem(pageKey + "ScrollPos");
  }
}

function showLoadingVe(btn, text) {
  if (btn.classList.contains('is-loading')) return false;

  // Identify current page for scroll preservation
  const pageKey = window.location.pathname.split('/').pop().replace('.do', '');
  saveScrollPosition(pageKey);

  btn.classList.add('is-loading');

  // Prepend spinner and update text
  const spinner = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" style="margin-right: 5px;"></span> ';
  btn.innerHTML = spinner + text;

  // Disable buttons after a short delay to allow form submission to capture the clicked button's name/value
  setTimeout(() => {
    const footer = btn.closest('.row.justify-content-center') || btn.closest('.buttons-container') || btn.closest('.form-actions');
    if (footer) {
      const buttons = footer.querySelectorAll('button');
      buttons.forEach(b => {
        if (b !== btn) b.disabled = true;
      });
    }
    btn.disabled = true;
  }, 10);
  
  return true;
}

function confirmerEtOuvrir(id, entier, btn) {
  entier = parseInt(entier);
  let txt = "";
  let loadingText = "";
  // Ecriture du texte de la box
  if (entier === 1) {
    txt = "Vous allez envoyer un mail de réinitialisation de mot de passe, voulez-vous continuer ?";
    loadingText = "Envoi...";
  } else if (entier === 2) {
    txt = "Vous allez enregistrer le formulaire, voulez-vous continuer ?";
    loadingText = "Sauvegarde...";
  } else if (entier === 3) {
    txt = "Vous allez valider le formulaire, vous ne pourrez plus y toucher ensuite, voulez-vous continuer ?";
    loadingText = "Validation...";
  } else if (entier === 4) {
    txt = "Vous allez refuser le formulaire, l'élève va recevoir un mail lui expliquant pourquoi, voulez-vous continuer ?";
    loadingText = "Refus en cours...";
  }

  if (confirm(txt)) {
    if (entier === 4) {
      if (!messageCommVide(id)) {
        return false;
      }
    }
    openForm(id);
    if (btn) {
      showLoadingVe(btn, loadingText);
    }
    return true;
  }
  return false;
}

function messageCommVide(id) {
  /*
   * var commentaireDiv = document.getElementById("commentairesVeDiv");
  var commLabel = commentaireDiv.firstElementChild;
  var commentaire = commLabel.nextElementSibling;
  const comm = commentaire.textContent;
   */
  const comm = document.getElementById("commentairesVe").value;
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
