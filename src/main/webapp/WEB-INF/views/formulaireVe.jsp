<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="fr-fr">

            <head>
                <title>FORMULAIRE_VE</title>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
                <link href="css/default.css" type="text/css" rel="stylesheet" />
                <link href="css/formulaire.css" type="text/css" rel="stylesheet" />
                <link href="css/header.css" type="text/css" rel="stylesheet" />
                <script src="js/formulaire.js"></script>
            </head>

            <body>
                <jsp:include page="/WEB-INF/views/header.jsp" />
                <div class="main-container">
                    <div class="info-card" style="position: relative;">

                        <form method="post" action="formulaireVe.do"
                            style="position: absolute; top: 20px; right: 20px; z-index: 10;">
                            <input type="hidden" name="connexionId" value="${connexionId}" />
                            <input type="hidden" name="id" value="${item.formulaireId}" />
                            <input type="hidden" name="personneId" value="${item.personneId.personneId}" />
                            <input type="hidden" name="formulaireId" value="${item.formulaireId}" />
                            <button class="refresh-btn" title="Rafraîchir" onclick="this.disabled=true; this.innerHTML='<img src=\'img/refresh.png\' class=\'refresh-icon spin\' /> Chargement...'; this.form.submit();">
                                <img src="img/refresh.png" alt="Refresh" class="refresh-icon" />
                                Rafraîchir
                            </button>
                        </form>

                        <div class="form-header">
                            <div>
                                <h2>Validation du Formulaire</h2>
                                <p class="subtitle">Dossier de ${item.personneId.prenom} ${item.personneId.nom}</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">

                                    <c:choose>
                                        <c:when test="${item.estConforme}">
                                            <p>Le formulaire a déjà été validé</p>
                                        </c:when>
                                        <c:when test="${(!item.estValide) && (! empty item.commentairesVe)}">
                                            <p>Le formulaire a été refusé mais peut être corrigé</p>
                                        </c:when>
                                    </c:choose>

                                    <form id="formVe" method="post">
                                        <script>
                                            // Récupérer la valeur de formulaireId depuis le JSP
                                            var formulaireId = "${item.formulaireId}";
                                        </script>

                                        <div class="table-responsive">
                                            <div class="modern-form-table">

                                                <div class="form-row">
                                                    <div class="label-col"><label for="nom">Nom</label></div>
                                                    <div class="input-col">
                                                        <input type="hidden" name="numSCEI"
                                                            value="${item.numeroScei}" />
                                                        <input type="text" id="nom" name="nom"
                                                            value="${item.personneId.nom}" disabled="disabled"
                                                            required="required" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_nom"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'nom\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_nom" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_nom">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="prenom">Prenom</label>
                                                    </div>
                                                    <div class="input-col">
                                                        <input type="text" id="prenom" name="prenom"
                                                            value="${item.personneId.prenom}" disabled="disabled"
                                                            required="required" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_prenom"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'prenom\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_prenom" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_prenom">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="dateNaissance">Date de
                                                            Naissance(XX/MM/YYYY)</label></div>
                                                    <div class="input-col">
                                                        <fmt:formatDate value="${item.dateDeNaissance}"
                                                            pattern="dd/MM/yyyy" var="formattedDate" />
                                                        <input type="text" id="dateNaissance" name="dateDeNaissance"
                                                            class="dateNaissance" value="${formattedDate}"
                                                            disabled="disabled" required="required" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_dateNaissance"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'dateNaissance\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_dateNaissance" src="img/close.png"
                                                                class="avion" alt="Verrouillé" />
                                                            <span id="text_locker_dateNaissance">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="ville">Ville</label>
                                                    </div>
                                                    <div class="input-col">
                                                        <input type="text" id="ville" name="ville" value="${item.ville}"
                                                            disabled="disabled" required="required" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_ville"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'ville\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_ville" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_ville">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="codePostal">Code
                                                            Postal</label></div>
                                                    <div class="input-col">
                                                        <input type="text" id="codePostal" name="codePostal"
                                                            value="${item.codePostal}" disabled="disabled" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_codePostal"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'codePostal\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_codePostal" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_codePostal">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col">Pays</div>
                                                    <div class="input-col">
                                                        <select id='pays' name="pays" disabled='disabled'
                                                            required="required">
                                                            <c:forEach var="pays" items="${pays}">
                                                                <option value=${pays.paysId}
                                                                    ${item.paysId.paysId==pays.paysId?'selected="selected"' : ''}>${pays.paysNom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="action-col text-center align-middle">
                                                <button type="button" id="locker_pays" 
                                                                    class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center" 
                                                                    ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'pays\')"' }
                                                                    style="gap: 5px; margin:auto; width: 140px;">
                                                                    <img id="img_pays" src="img/close.png" class="avion"
                                                                        alt="Verrouillé" />
                                                                    <span id="text_locker_pays">Verrouillé</span>
                                                                    </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="mail">Mail</label></div>
                                                    <div class="input-col">
                                                        <input type="text" id="mail" name="mail" value="${item.mail}"
                                                            placeholder="insérer votre mail" disabled="disabled"
                                                            required="required" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_mail"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'mail\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_mail" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_mail">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col">Genre</div>
                                                    <div class="input-col">
                                                        <select id="Genre" name="Genre" disabled="disabled"
                                                            required="required">
                                                            <c:if
                                                                test="${(empty item.genreId) || (item.genreId.genreId <= 0)}">
                                                                <option value=0 selected="selected">
                                                                    ------------------------------------------------
                                                                </option>
                                                            </c:if>
                                                            <c:forEach var="genre" items="${genresList}">
                                                                <option value="${genre.genreId}" ${(! empty
                                                                    item.genreId) &&
                                                                    (genre.genreId==item.genreId.genreId)
                                                                    ? 'selected="selected"' : '' } readonly="readonly">
                                                                    ${genre.genreNom}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <br />
                                                        Initial : ${item.genreAttendu.genreNom}
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_Genre"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'Genre\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_Genre" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_Genre">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="tel">Numéro de
                                                            téléphone</label></div>
                                                    <div class="input-col">
                                                        <input id="tel" type="text" name="tel" value="${item.numeroTel}"
                                                            disabled="disabled" required="required" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_tel"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'tel\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_tel" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_tel">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="tel2">Deuxième numéro de
                                                            téléphone</label></div>
                                                    <div class="input-col">
                                                        <input id="tel2" type="text" name="tel2" value="${item.tel2}"
                                                            disabled="disabled" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_tel2"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'tel2\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_tel2" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_tel2">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col">Êtes-vous boursier ?</div>
                                                    <div class="input-col">
                                                        <select name="boursier" id="boursier" disabled="disabled"
                                                            required="required">
                                                            <c:if test="${(empty item.estBoursier)}">
                                                                <option value="null" ${empty item.estBoursier
                                                                    ? 'selected="selected"' : '' }>---</option>
                                                            </c:if>
                                                            <option value="true" ${item.estBoursier=='true'
                                                                ? 'selected="selected"' : '' }>Oui</option>
                                                            <option value="false" ${item.estBoursier=='false'
                                                                ? 'selected="selected"' : '' }>Non</option>
                                                        </select>
                                                        <c:choose>
                                                            <c:when
                                                                test="${item.estBoursier && (! item.hasBourseFile())}">
                                                                <button type="submit" class="btn btn-danger mt-2"
                                                                    disabled="disabled">
                                                                    Preuve manquante
                                                                </button>
                                                            </c:when>
                                                            <c:when test="${item.estBoursier}">
                                                                <button formaction="telechargerBourse.do" type="submit"
                                                                    id="telechargement" class="btn btn-primary mt-2">
                                                                    Télécharger la preuve <img id="img_tel"
                                                                        src="img/download.png" class="icon"
                                                                        alt="download proof" />
                                                                </button>
                                                            </c:when>
                                                        </c:choose>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_boursier"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'boursier\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_boursier" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_boursier">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="souhait">Préférence
                                                            logement</label></div>
                                                    <div class="input-col">
                                                        <select id="souhait" name="Souhait" disabled="disabled"
                                                            required="required">
                                                            <option value=0 ${(empty item.souhaitId) ||
                                                                (item.souhaitId.souhaitId <=0) ? 'selected="selected"'
                                                                : '' }>
                                                                ---
                                                            </option>
                                                            <c:forEach var="souhait" items="${souhaitsList}">
                                                                <option value="${souhait.souhaitId}" ${(! empty
                                                                    item.souhaitId) &&
                                                                    (souhait.souhaitId==item.souhaitId.souhaitId)
                                                                    ? 'selected="selected"' : '' }>
                                                                    ${souhait.souhaitType}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_souhait"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'souhait\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_souhait" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_souhait">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="pmr">Avez-vous besoin de
                                                            dispositions particulières<br />(pmr, traitement
                                                            médical...) ?</label></div>
                                                    <div class="input-col">
                                                        <select name="pmr" id="pmr" disabled="disabled"
                                                            required="required">
                                                            <c:if test="${empty item.estPmr}">
                                                                <option value="null" selected="selected">---
                                                                </option>
                                                            </c:if>
                                                            <option value="true" ${item.estPmr=='true'
                                                                ? 'selected="selected"' : '' }>Oui</option>
                                                            <option value="false" ${item.estPmr=='false'
                                                                ? 'selected="selected"' : '' }>Non</option>
                                                        </select>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_pmr"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'pmr\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_pmr" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_pmr">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col" style="color: var(--brand-blue);">
                                                        <label for="comEleve">Commentaire Eleve</label>
                                                    </div>
                                                    <div class="input-col" id="comEleve"
                                                        style="color: #495057; width: 70%; padding: 15px 20px; flex-grow: 1; font-style: italic;">
                                                        ${not empty item.commentairesEleve ?
                                                        item.commentairesEleve : "Aucun commentaire laissé par
                                                        l'élève."}
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="table-responsive mt-5">
                                            <h4 class="mb-3" style="color: #333;">Informations Administratives
                                            </h4>
                                            <div class="modern-form-table">

                                                <div class="form-row">
                                                    <div class="label-col"><label for="distance">Distance</label></div>
                                                    <div class="input-col">
                                                        <input id="distance" type="number" name="distance"
                                                            value="${item.distance}" disabled="disabled" />
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_distance"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'distance\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_distance" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_distance">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label for="rang">Rang</label></div>
                                                    <div class="input-col">
                                                        <select id="rang" name="rang" disabled="disabled">
                                                            <option value=0 ${item.rang==0 ? 'selected="selected"' : ''
                                                                }>
                                                                ---
                                                            </option>
                                                            <option value=1 ${item.rang==1 ? 'selected="selected"' : ''
                                                                }>1</option>
                                                            <option value=2 ${item.rang==2 ? 'selected="selected"' : ''
                                                                }>2</option>
                                                            <option value=3 ${item.rang==3 ? 'selected="selected"' : ''
                                                                }>3</option>
                                                            <option value=4 ${item.rang==4 ? 'selected="selected"' : ''
                                                                }>4</option>
                                                        </select>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_rang"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'rang\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_rang" src="img/close.png" class="avion"
                                                                alt="Verrouillé" />
                                                            <span id="text_locker_rang">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col"><label
                                                            for="international">International</label></div>
                                                    <div class="input-col">
                                                        <select name="international" id="international"
                                                            disabled="disabled">
                                                            <c:if test="${empty item.international}">
                                                                <option value="null" selected="selected">---
                                                                </option>
                                                            </c:if>
                                                            <option value="true" ${item.international=='true'
                                                                ? 'selected="selected"' : '' }>Oui</option>
                                                            <option value="false" ${item.international=='false'
                                                                ? 'selected="selected"' : '' }>Non</option>
                                                        </select>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_international"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'international\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_international" src="img/close.png"
                                                                class="avion" alt="Verrouillé" />
                                                            <span id="text_locker_international">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col" style="color: red;">
                                                        Commentaire Mission Logement<br />
                                                        <small>(obligatoire en cas de refus)<br />(sera transmis
                                                            à l'étudiant en cas de refus du dossier)</small>
                                                    </div>
                                                    <div id="commentairesVeDiv" class="input-col">
                                                        <label for="commentairesVe" class="sr-only">
                                                            commentaires Ve</label>
                                                        <textarea class="commentairesVe" cols="40" rows="5"
                                                            name="commentairesVe" id="commentairesVe"
                                                            disabled="disabled">${item.commentairesVe}</textarea>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_commentairesVe"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'commentairesVe\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_commentairesVe" src="img/close.png"
                                                                class="avion" alt="Verrouillé" />
                                                            <span id="text_locker_commentairesVe">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="label-col">
                                                        Commentaire Interne & Historique<br />
                                                        <span
                                                            style="font-weight: normal; font-size: 0.85em; color: #666; display: block; margin-top: 5px; max-height: 100px; overflow-y: auto;">
                                                            <c:choose>
                                                                <c:when test="${not empty item.traitementCollection}">
                                                                    Historique des modifications : <br />
                                                                    <ul style="padding-left: 15px; margin-bottom: 0;">
                                                                        <c:forEach var="trait"
                                                                            items="${item.traitementCollection}">
                                                                            <li>
                                                                                <strong>${trait.personneId.prenom.substring(0,1).toUpperCase()}${trait.personneId.nom.substring(0,1).toUpperCase()}</strong>
                                                                                -
                                                                                <fmt:formatDate
                                                                                    value="${trait.dateTraitement}"
                                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                                            </li>
                                                                        </c:forEach>
                                                                    </ul>
                                                                </c:when>
                                                                <c:when test="${not empty item.assistant}">
                                                                    Dernière modification par : <br />
                                                                    <strong>${item.assistant.prenom.substring(0,1).toUpperCase()}${item.assistant.nom.substring(0,1).toUpperCase()}</strong>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <em>Aucune note interne</em>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <div class="input-col">
                                                        <label for="commentairesInternes" class="sr-only">
                                                            commentaires internes</label>
                                                        <textarea class="form-control" cols="40" rows="4"
                                                            name="commentairesInternes" id="commentairesInternes"
                                                            disabled="disabled">${item.commentairesInternes}</textarea>
                                                    </div>
                                                    <div class="action-col text-center align-middle">
                                                        <button type="button" id="locker_commentairesInternes"
                                                            class="btn ${(item.estConforme && !connexion.isAdmin()) ? 'btn-secondary' : 'btn-outline-dark'} btn-sm d-flex align-items-center justify-content-center"
                                                            ${(item.estConforme && !connexion.isAdmin()) ? 'disabled="disabled"' : 'onclick="delock(\'commentairesInternes\')"' }
                                                            style="gap: 5px; margin:auto; width: 140px;">
                                                            <img id="img_commentairesInternes" src="img/close.png"
                                                                class="avion" alt="Verrouillé" />
                                                            <span
                                                                id="text_locker_commentairesInternes">Verrouillé</span>
                                                        </button>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="container mt-4 mb-4 text-center">
                                            <div class="row justify-content-center">
                                                <div class="col-md-10">
                                                    <input type="hidden" name="id" value="${item.formulaireId}" />
                                                    <input type="hidden" name="personneId"
                                                        value="${item.personneId.personneId}" />
                                                    <input type="hidden" name="connexionId" value="${connexionId}" />

                                                    <c:choose>
                                                        <c:when test="${item.estConforme}">
                                                            <p>Le formulaire a déjà été validé.</p>
                                                            <c:if test="${!empty item.lastTraitement}">
                                                                <p>Validé par
                                                                    ${item.lastTraitement.personneId.prenom.toUpperCase()}
                                                                    ${item.lastTraitement.personneId.nom.toUpperCase()}
                                                                    le
                                                                    <fmt:formatDate
                                                                        value="${item.lastTraitement.dateTraitement}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                </p>
                                                            </c:if>
                                                            <c:if
                                                                test="${empty item.lastTraitement and !empty item.assistant}">
                                                                <p>Validé par
                                                                    ${item.assistant.prenom.substring(0,1).toUpperCase()}${item.assistant.nom.substring(0,1).toUpperCase()}
                                                                </p>
                                                            </c:if>
                                                            <c:if
                                                                test="${(! empty connexion) && (connexion.isAdmin())}">
                                                                <button onclick="openForm('formVe'); showLoadingVe(this, 'Sauvegarde...');"
                                                                    formaction="EnregistrerFormVe.do" type="submit"
                                                                    name="enregistrer" class="btn btn-primary mr-3"
                                                                    value="enregistrer">
                                                                    Forcer la sauvegarde <img src="img/save.png"
                                                                        class="icon" alt="save" />
                                                                </button>
                                                            </c:if>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <c:if test="${!empty item.lastTraitement}">
                                                                <p>Refusé par
                                                                    ${item.lastTraitement.personneId.prenom.toUpperCase()}
                                                                    ${item.lastTraitement.personneId.nom.toUpperCase()}
                                                                    le
                                                                    <fmt:formatDate
                                                                        value="${item.lastTraitement.dateTraitement}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                </p>
                                                            </c:if>
                                                            <c:if
                                                                test="${empty item.lastTraitement and !empty item.assistant}">
                                                                <p>Refusé par
                                                                    ${item.assistant.prenom.substring(0,1).toUpperCase()}${item.assistant.nom.substring(0,1).toUpperCase()}
                                                                </p>
                                                            </c:if>

                                                            <button onclick="return confirmerEtOuvrir('formVe', 1, this)"
                                                                formaction="AnnulerPwd.do" type="submit"
                                                                name="annulerpwd" class="btn btn-info mr-2"
                                                                value="annulerpwd" <c:if
                                                                test="${empty item.personneId.password}">disabled="disabled"
                                                                </c:if>>
                                                                Reinitialiser Mot de Passe
                                                                <img src="img/refuse.png" class="icon"
                                                                    alt="Reinitialiser" />
                                                            </button>

                                                            <button onclick="return confirmerEtOuvrir('formVe', 2, this)"
                                                                formaction="EnregistrerFormVe.do" type="submit"
                                                                name="enregistrer" class="btn btn-primary mr-2"
                                                                value="enregistrer">
                                                                Sauvegarder
                                                                <img src="img/save.png" class="icon" alt="save" />
                                                            </button>

                                                            <button onclick="return confirmerEtOuvrir('formVe', 3, this)"
                                                                formaction="ValiderFormVe.do" type="submit"
                                                                name="valider" class="btn btn-success mr-2"
                                                                value="valider">
                                                                Valider
                                                                <img src="img/coche.png" class="icon" alt="Valider" />
                                                            </button>

                                                            <button onclick="return confirmerEtOuvrir('formVe', 4, this)"
                                                                formaction="RefuserFormVe.do" type="submit"
                                                                name="refuser" class="btn btn-danger" value="refuser">
                                                                Refuser<img src="img/refuse.png" class="icon"
                                                                    alt="Refuser" />
                                                            </button>

                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            </script>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                </div>

                <script>
                    window.onload = function () {
                        var message = "<%= request.getAttribute("confirmationMessage")%>";
                        if (message && message.trim() !== "null") {
                            alert(message);
                        }
                    };
                </script>
            </body>

            </html>