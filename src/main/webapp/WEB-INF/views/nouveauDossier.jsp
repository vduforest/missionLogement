<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="fr-fr">

            <head>
                <title>Nouveau Dossier Élève</title>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
                <link href="css/header.css" type="text/css" rel="stylesheet" />
                <link href="css/default.css" type="text/css" rel="stylesheet" />
                <link href="css/formulaire.css" type="text/css" rel="stylesheet" />
            </head>

            <body>
                <jsp:include page="/WEB-INF/views/header.jsp" />

                <div class="main-container">
                    <div class="info-card">

                        <div class="form-header">
                            <h2>Création d'un dossier élève</h2>
                            <p class="subtitle">Mission Logement</p>
                        </div>

                        <div class="alert alert-warning">
                            <b>MODE CRÉATION :</b> Vous créez un compte étudiant et remplissez son formulaire dans la
                            même action.
                        </div>

                        <c:if test="${not empty creationError}">
                            <div class="alert alert-danger">
                                <b>Erreur :</b><br />
                                ${creationError}
                            </div>
                        </c:if>

                        <form id="logementForm" action="CreationNouveauDossier.do" method="POST"
                            enctype="multipart/form-data">
                            <input type="hidden" name="connexionId" value="${connexionId}" />

                            <div class="modern-form-table">
                                <div class="form-row">
                                    <div class="label-col">Numéro SCEI</div>
                                    <div class="input-col"><label for="scei">SCEI</label><input type="text" id="scei"
                                            name="numeroScei" value="${numeroScei}" required class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Nom</div>
                                    <div class="input-col"><label for="nom">Nom</label><input type="text" id="nom"
                                            name="nom" value="${nom}" required class="monitor-change" /></div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Prénom</div>
                                    <div class="input-col"><label for="prenom">Prénom</label><input type="text"
                                            id="prenom" name="prenom" value="${prenom}" required
                                            class="monitor-change" /></div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Date de naissance</div>
                                    <div class="input-col">
                                        <label for="dateDeNaissance">Date de naissance</label>
                                        <!-- Format yyyy-MM-dd is needed for HTML5 type="date" -->
                                        <input type="date" id="dateDeNaissance" name="dateDeNaissance"
                                            value="${dateDeNaissanceStr}" required class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Genre</div>
                                    <div class="input-col">
                                        <label for="genre">Genre</label>
                                        <select name="Genre" id="genre" required="required" class="monitor-change">
                                            <option value=0>Sélectionner...</option>
                                            <c:forEach var="genreVar" items="${genresList}">
                                                <option value="${genreVar.genreId}" ${genreVar.genreId==genre
                                                    ? 'selected="selected"' : '' }>${genreVar.genreNom}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Adresse E-mail</div>
                                    <div class="input-col">
                                        <label for="mail">mail</label>
                                        <input type="text" id="mail" name="mail" value="${mail}"
                                            placeholder="exemple@ec-nantes.fr" required="required"
                                            class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Téléphone</div>
                                    <div class="input-col">
                                        <label for="tel">Téléphone</label>
                                        <input type="text" id="tel" name="tel" value="${tel}" required="required"
                                            class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Téléphone 2 (Optionnel)</div>
                                    <div class="input-col">
                                        <label for="tel2">Téléphone 2</label>
                                        <input type="text" name="tel2" id="tel2" value="${tel2}"
                                            class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Ville</div>
                                    <div class="input-col">
                                        <label for="ville">Ville</label>
                                        <input type="text" id="ville" name="ville" value="${ville}" required
                                            class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Code Postal</div>
                                    <div class="input-col">
                                        <label for="codePostal">Code postal</label>
                                        <input type="text" id="codePostal" name="codePostal" value="${codePostal}"
                                            required class="monitor-change" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Pays</div>
                                    <div class="input-col">
                                        <label for="pays">Pays</label>
                                        <select name="pays" id="pays" required="required" class="monitor-change">
                                            <option value=0>Sélectionner...</option>
                                            <c:forEach var="paysVar" items="${paysList}">
                                                <option value="${paysVar.paysId}" ${(not empty pays and
                                                    paysVar.paysId==pays) or (empty pays and paysVar.paysId==1)
                                                    ? 'selected="selected"' : '' }>${paysVar.paysNom}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Êtes-vous boursier ?</div>
                                    <div class="input-col">
                                        <div class="radio-options">
                                            <label for="ouiB">Oui</label>
                                            <input type="radio" name="bourse" id="ouiB" value="true" ${bourse=='true'
                                                ? 'checked' : '' } required class="monitor-change" />
                                            <label for="nonB">Non</label>
                                            <input type="radio" name="bourse" id="nonB" value="false" ${bourse=='false'
                                                ? 'checked' : '' } required class="monitor-change" />
                                        </div>
                                        <div id="bourseUploadSection" class="mt-2">
                                            <label for="preuveBourse">Preuve (Obligatoire si boursier)</label>
                                            <input type="file" id="preuveBourse" name="preuveBourse"
                                                class="form-control-file mt-2 monitor-change"
                                                accept="image/png,image/jpeg,application/pdf" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Préférence logement</div>
                                    <div class="input-col">
                                        <label for="pref_logement">préférence logement</label>
                                        <select name="Souhait" id="pref_logement" required="required"
                                            class="monitor-change">
                                            <option value=0>Choisir une préférence...</option>
                                            <c:forEach var="souhaitVar" items="${souhaitsList}">
                                                <option value="${souhaitVar.souhaitId}" ${souhaitVar.souhaitId==souhait
                                                    ? 'selected="selected"' : '' }>${souhaitVar.souhaitType}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Dispositions particulières <br>(PMR, Handicap...) ?</div>
                                    <div class="input-col radio-options">
                                        <input type="radio" name="pmr" id="ouip" value="true" ${pmr=='true' ? 'checked'
                                            : '' } required class="monitor-change" /> <label for="ouip">Oui</label>
                                        <input type="radio" name="pmr" id="nonp" value="false" ${pmr=='false'
                                            ? 'checked' : '' } required class="monitor-change" /> <label
                                            for="nonp">Non</label>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="label-col">Informations Complémentaires</div>
                                    <div class="input-col">
                                        <label for="infoSupplementaires">infos supplémentaires</label>
                                        <textarea id="infoSupplementaires" name="infoSupplementaires" rows="5"
                                            class="monitor-change">${infoSupplementaires}</textarea>
                                    </div>
                                </div>

                            </div>

                            <div class="form-actions text-center">
                                <div class="buttons-container">
                                    <button type="submit" id="btnSubmit" name="soumettre"
                                        class="custom-button btn-submit-active" value="soumettre">
                                        Créer et Soumettre le dossier
                                    </button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>

                <script>
                    function showLoading(btn, text) {
                        setTimeout(() => {
                            const buttons = document.querySelectorAll(".custom-button");
                            buttons.forEach(b => b.disabled = true);
                            if (btn) {
                                btn.innerHTML = `<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> ${text}`;
                            }
                        }, 10);
                        return true;
                    }

                    document.addEventListener("DOMContentLoaded", function () {
                        const form = document.getElementById("logementForm");

                        form.addEventListener("submit", function (event) {
                            const btnSubmit = document.getElementById("btnSubmit");

                            if (btnSubmit && btnSubmit.disabled) {
                                event.preventDefault();
                                return false;
                            }

                            // Validation listes déroulantes
                            const prefLogement = document.getElementById("pref_logement");
                            if (prefLogement && prefLogement.value === "0") {
                                event.preventDefault();
                                alert("Veuillez sélectionner une préférence de logement.");
                                return false;
                            }

                            const genre = document.getElementById("genre");
                            if (genre && genre.value === "0") {
                                event.preventDefault();
                                alert("Veuillez sélectionner un genre.");
                                return false;
                            }

                            const pays = document.getElementById("pays");
                            if (pays && pays.value === "0") {
                                event.preventDefault();
                                alert("Veuillez sélectionner un pays.");
                                return false;
                            }

                            // Validation boursier
                            const ouiB = document.getElementById("ouiB");
                            const preuveBourse = document.getElementById("preuveBourse");
                            if (ouiB && ouiB.checked && (!preuveBourse || !preuveBourse.files || preuveBourse.files.length === 0)) {
                                event.preventDefault();
                                alert("Vous avez indiqué que l'étudiant est boursier. Veuillez fournir le justificatif de bourse avant de soumettre.");
                                return false;
                            }

                            const confirmation = confirm("Confirmez-vous la création définitive du dossier pour cet élève ?");
                            if (!confirmation) {
                                event.preventDefault();
                                return false;
                            }

                            showLoading(btnSubmit, "Création en cours...");
                        });
                    });
                </script>
            </body>

            </html>