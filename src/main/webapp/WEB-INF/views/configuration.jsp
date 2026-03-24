<%-- Document : configuration Created on : 27 janv. 2025, 16:38:56 Author : Amolz --%>
    <%@taglib prefix="c" uri="jakarta.tags.core" %>
        <%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html lang="fr-fr">

                <head>
                    <title>CONFIGURATION - MISSION LOGEMENT</title>
                    <meta charset="UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">

                    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/default.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/configuration.css?v=4">

                    <script src="${pageContext.request.contextPath}/js/configuration.js"></script>
                    <script>
                        function showLoadingConfig(btn, text) {
                            if (btn.classList.contains('is-loading')) return false;
                            btn.classList.add('is-loading');

                            const spinner = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" style="margin-right: 5px;"></span> ';
                            btn.innerHTML = spinner + text;

                            // Disable after short delay to ensure submit name/value is sent
                            setTimeout(() => {
                                const card = btn.closest('.info-card');
                                const buttons = card.querySelectorAll('button[type="submit"], button.Supprimer, button.Import');
                                buttons.forEach(b => {
                                    if (b !== btn) b.disabled = true;
                                });
                                btn.disabled = true;
                            }, 10);
                            
                            return true;
                        }

                        function getCookie(name) {
                            var value = "; " + document.cookie;
                            var parts = value.split("; " + name + "=");
                            if (parts.length === 2) return parts.pop().split(";").shift();
                        }

                        function expireCookie(name) {
                            document.cookie = name + "=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;";
                        }

                        function checkDownload(btnSelector, originalText) {
                            const interval = setInterval(() => {
                                if (getCookie("fileDownload")) {
                                    expireCookie("fileDownload");
                                    const btn = document.querySelector(btnSelector);
                                    if (btn) {
                                        btn.disabled = false;
                                        btn.classList.remove('is-loading');
                                        btn.innerHTML = originalText;
                                        
                                        // Also re-enable other buttons in the same card
                                        const card = btn.closest('.info-card');
                                        if (card) {
                                            const buttons = card.querySelectorAll('button[type="submit"], button.Supprimer, button.Import');
                                            buttons.forEach(b => b.disabled = false);
                                        }
                                    }
                                    clearInterval(interval);
                                }
                            }, 1000);
                            setTimeout(() => clearInterval(interval), 60000);
                        }

                        function checkSubmit(formId, action, message, btn) {
                            if (confirm(message)) {
                                if (btn) showLoadingConfig(btn, "Purge...");
                                var form = document.getElementById(formId);
                                form.action = action;
                                form.submit();
                                return true;
                            }
                            return false;
                        }

                        function handleImport(input) {
                            if (input.files && input.files.length > 0) {
                                const btn = document.querySelector('.Import');
                                const originalText = btn.innerHTML;
                                if (showLoadingConfig(btn, 'Import en cours...')) {
                                    checkDownload('.Import', originalText);
                                    document.getElementById('importForm').submit();
                                }
                            }
                        }
                    </script>
                </head>

                <body>
                    <jsp:include page="/WEB-INF/views/header.jsp" />

                    <div class="main-container">
                        <div class="info-card" style="position: relative;">

                            <form method="post" action="configuration.do"
                                style="position: absolute; top: 20px; right: 20px; z-index: 10;">
                                <input type="hidden" name="connexionId" value="${connexionId}" />
                                <button class="refresh-btn" title="Rafraîchir la page" onclick="this.disabled=true; this.innerHTML='<img src=\'img/refresh.png\' class=\'refresh-icon spin\' /> Chargement...'; this.form.submit();">
                                    <img src="img/refresh.png" alt="Refresh" class="refresh-icon" /> Rafraîchir
                                </button>
                            </form>

                            <div class="form-header">
                                <div>
                                    <h2>Configuration du système</h2>
                                    <p class="subtitle">Paramètres globaux et modèles de communication</p>
                                </div>
                            </div>

                            <div class="status-highlight">
                                Statut actuel : <strong>${missionStatus == 0 ? 'Avant mission' : (missionStatus == 1 ?
                                    'Mission en cours' : 'Mission fermée')}</strong>
                            </div>

                            <!-- SECTION 1: STATUT ET DATES -->
                            <form action="saveConfig.do" method="POST">
                                <input type="hidden" name="connexionId" value="${connexionId}" />
                                <h3>Paramètres de la mission</h3>
                                <div class="modern-form-table">
                                    <div class="form-row">
                                        <div class="label-col">Statut de la mission</div>
                                        <div class="input-col">
                                            <select name="newStatus" id="missionStatus">
                                                <option value="0" ${missionStatus==0 ? 'selected' : '' }>Avant mission
                                                </option>
                                                <option value="1" ${missionStatus==1 ? 'selected' : '' }>Mission en
                                                    cours</option>
                                                <option value="2" ${missionStatus==2 ? 'selected' : '' }>Mission fermée
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Date de début</div>
                                        <div class="input-col">
                                            <input type="datetime-local" id="date_debut" name="date_debut"
                                                class="date_debut" value="${date_debut}" />
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Date de fin</div>
                                        <div class="input-col">
                                            <input type="datetime-local" id="date_fin" name="date_fin" class="date_fin"
                                                value="${date_fin}" />
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Actions globales</div>
                                        <div class="input-col">
                                            <div class="button-group">
                                                <button type="submit" class="Enregistrer" onclick="showLoadingConfig(this, 'Sauvegarde...')">
                                                    Mettre à jour <img src="img/save.png" class="icon" />
                                                </button>
                                                <button type="button" <c:if
                                                    test="${missionStatus != 2}">disabled="disabled"</c:if>
                                                    onclick="return checkSubmit('configuration', 'supprimerDonnees.do',
                                                    '!!Attention!! \n Voulez-vous vraiment supprimer ces données ?\n
                                                    Cette action est irréversible', this);"
                                                    id="supprimerDonnees" class="Supprimer">
                                                    Purger les données <img src="img/warning.png" class="icon" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <!-- SECTION 2: IMPORT CSV -->
                            <c:if test="${missionStatus != 2}">
                                <h3>Importation des élèves</h3>
                                <div class="alert-csv">
                                    <strong>Structure attendue du fichier CSV :</strong>
                                    <pre>Genre;Nom;Prénom;Date de naissance;Code Postal;Ville;PAYS;NUMERO SCEI;MAIL

Exemple:
M.;Durand;Lucas;15/06/2002;75015;Paris;France;84532;lucas.durand@eleves.ec-nantes.fr</pre>
                                </div>
                                <form id="importForm" action="importEleves.do" method="POST"
                                    enctype="multipart/form-data">
                                    <input type="hidden" name="connexionId" value="${connexionId}" />
                                    <input type="file" id="fichierImport" name="file" class="fichierImport"
                                        accept="text/.csv" style="display: none;"
                                        onchange="handleImport(this);" />
                                    <div class="text-center mb-4">
                                        <button type="button" class="Import"
                                            onclick="document.getElementById('fichierImport').click();">
                                            Choisir un fichier CSV et importer les dossiers
                                            <img src="img/import.png" class="import" />
                                        </button>
                                    </div>
                                </form>
                            </c:if>

                            <!-- SECTION 3: EMAILS ET CONTENU -->
                            <form action="saveConfig.do" method="POST" id="configuration">
                                <input type="hidden" name="connexionId" value="${connexionId}" />

                                <h3>Configuration des Emails</h3>
                                <div class="modern-form-table">
                                    <div class="form-row">
                                        <div class="label-col">Adresse mail de l'envoyeur</div>
                                        <div class="input-col">
                                            <input type="text" name="adresse_mail_envoyeur" class="mail_envoyeur"
                                                value="${adresse_mail_envoyeur}" />
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Mail d'authentification (Tokens)</div>
                                        <div class="input-col">
                                            <textarea name="message_contact">${message_contact}</textarea>
                                            <div class="button-group">
                                                <button type="submit" class="EnvoiMails" formaction="tokenmail.do" <c:if
                                                    test="${missionStatus != 0}">disabled="disabled" title="Disponible
                                                    uniquement 'Avant mission'"</c:if> onclick="showLoadingConfig(this, 'Envoi en cours...')">
                                                    Envoyer les mails d'authentification<img src="img/mail.png"
                                                        class="mails" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Mail de réinitialisation</div>
                                        <div class="input-col">
                                            <textarea name="message_reset_password">${message_reset_password}</textarea>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Mail après fermeture</div>
                                        <div class="input-col">
                                            <textarea name="message_mission_fermee">${message_mission_fermee}</textarea>
                                            <div class="button-group">
                                                <button type="submit" class="EnvoiMails" formaction="envoiemailfin.do"
                                                    <c:if test="${missionStatus != 2}">disabled="disabled"
                                                    title="Disponible uniquement quand la 'Mission est fermée'"</c:if> onclick="showLoadingConfig(this, 'Envoi en cours...')">
                                                    Envoyer les mails de fin <img src="img/mail.png" class="mails" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Mail dossier incomplet</div>
                                        <div class="input-col">
                                            <textarea
                                                name="message_dossier_incomplet">${message_dossier_incomplet}</textarea>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="label-col">Mail dossier complet</div>
                                        <div class="input-col">
                                            <textarea
                                                name="message_dossier_complet">${message_dossier_complet}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <h3>Messages des Pages</h3>
                                <div class="modern-form-table">
                                    <div class="form-row">
                                        <div class="label-col">Connexion (Avant mission)</div>
                                        <div class="input-col">
                                            <textarea
                                                name="message_avant_connexion">${message_avant_connexion}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="label-col">Connexion (Pendant mission)</div>
                                        <div class="input-col">
                                            <textarea name="message_pge_connexion">${message_pge_connexion}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="label-col">Page d'attente (Fermé)</div>
                                        <div class="input-col">
                                            <textarea name="message_page_attente">${message_page_attente}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="label-col">Consignes (Haut du formulaire)</div>
                                        <div class="input-col">
                                            <textarea
                                                name="message_page_informations">${message_page_informations}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <h3>Infobulles du Formulaire</h3>
                                <div class="modern-form-table">
                                    <div class="form-row">
                                        <div class="label-col">Identité</div>
                                        <div class="input-col">
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Nom</label>
                                                <input type="text" name="tooltip_nom" value="${tooltip_nom}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Prénom</label>
                                                <input type="text" name="tooltip_prenom" value="${tooltip_prenom}" />
                                            </div>
                                            <div>
                                                <label class="field-label">Infobulle Date de naissance</label>
                                                <input type="text" name="tooltip_date_naissance"
                                                    value="${tooltip_date_naissance}" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="label-col">Localisation</div>
                                        <div class="input-col">
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Ville</label>
                                                <input type="text" name="tooltip_ville" value="${tooltip_ville}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Code Postal</label>
                                                <input type="text" name="tooltip_code_postal"
                                                    value="${tooltip_code_postal}" />
                                            </div>
                                            <div>
                                                <label class="field-label">Infobulle Pays</label>
                                                <input type="text" name="tooltip_pays" value="${tooltip_pays}" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="label-col">Contact & Divers</div>
                                        <div class="input-col">
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Email</label>
                                                <input type="text" name="tooltip_mail" value="${tooltip_mail}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Confirmation Email</label>
                                                <input type="text" name="tooltip_confirm_mail"
                                                    value="${tooltip_confirm_mail}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Genre</label>
                                                <input type="text" name="tooltip_genre" value="${tooltip_genre}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Téléphone</label>
                                                <input type="text" name="tooltip_tel" value="${tooltip_tel}" />
                                            </div>
                                            <div>
                                                <label class="field-label">Infobulle Téléphone 2</label>
                                                <input type="text" name="tooltip_tel2" value="${tooltip_tel2}" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="label-col">Logement & Spécificités</div>
                                        <div class="input-col">
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Bourse</label>
                                                <input type="text" name="tooltip_bourse" value="${tooltip_bourse}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle Préférence Logement</label>
                                                <input type="text" name="tooltip_souhait" value="${tooltip_souhait}" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="field-label">Infobulle PMR / Handicap</label>
                                                <input type="text" name="tooltip_pmr" value="${tooltip_pmr}" />
                                            </div>
                                            <div>
                                                <label class="field-label">Infobulle Informations
                                                    Complémentaires</label>
                                                <input type="text" name="tooltip_infos" value="${tooltip_infos}" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-actions text-center">
                                    <button type="submit" class="Enregistrer"
                                        style="padding: 15px 60px; font-size: 1.1rem;" onclick="showLoadingConfig(this, 'Sauvegarde...')">
                                        Sauvegarder toute la configuration <img src="img/save.png" class="icon" />
                                    </button>
                                </div>
                            </form>

                        </div>
                    </div>
                </body>

                </html>