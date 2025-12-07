function chooseImport(){
    document.getElementById("fichierImport").click();
}

function importCSV(event) {
    const file = event.target.files[0];

    if (!file){
        alert("veuillez sélectionner un fichier .csv");
        return;
    }
}

function checkSubmit(formId, actionName, msg) {
    var result = confirm(msg);
    var formRef = document.getElementById(formId);
    if ((formRef !== null) && (result)) {
      formRef.action = actionName;
      formRef.submit();
      return true;
    }
    return false;
}


/*
document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("supprimerDonnees").addEventListener("click", function() {
        if (confirm("!!Attention!! \n Voulez-vous vraiment supprimer ces données ?\n Cette action est irréversible")) {
            fetch("supprimerDonnees.do", { method: "POST" })
                .then(response => {
                    if (response.ok) {
                        alert("Données supprimées avec succès !");
                        location.reload(); // Recharger la page après suppression
                    } else {
                        alert("Erreur lors de la suppression des données.");
                    }
                })
                .catch(error => console.error("Erreur:", error));
        }
    });
});
 */