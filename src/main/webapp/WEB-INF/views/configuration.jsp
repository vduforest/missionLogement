<%-- Document : configuration Created on : 27 janv. 2025, 16:38:56 Author : Amolz --%>
  <%@taglib prefix="c" uri="jakarta.tags.core" %>
    <%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="fr-fr">

        <head>
            <title>CONFIGURATION</title>
            <meta charset="UTF-8" />

            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/default.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/configuration.css?v=1">

            <script src="${pageContext.request.contextPath}/js/configuration.js"></script>
        </head>

        <body>
          <jsp:include page="/WEB-INF/views/header.jsp" />

          <div id="main">
            <div id="liste">
              <div class="py-3">
                <div class="container">

                  <div class="row">
                    <div class="col-md-12">
                      <h2 class="">Configuration</h2>
                    </div>
                  </div>

                  <div class="row">
                    <form action="saveConfig.do" method="POST">
                      <input type="hidden" name="connexionId" value="${connexionId}" />
                      <div class="col-md-12">
                        <div class="table-responsive">
                          <table class="table table-striped">
                            <tbody>
                              <tr>
                                <th>Statut de la mission :</th>
                                <td colspan="2">
                                  <select name="newStatus" id="missionStatus">
                                    <option value="0" ${missionStatus==0 ? 'selected' : '' }>Avant mission</option>
                                    <option value="1" ${missionStatus==1 ? 'selected' : '' }>Mission en cours</option>
                                    <option value="2" ${missionStatus==2 ? 'selected' : '' }>Mission fermée</option>
                                  </select>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Date de début de la Mission Logement</th>
                                <td colspan="2">
                                  <input type="datetime-local" id="date_debut" name="date_debut" class="date_debut"
                                    value="${date_debut}" />
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Date de fin de la Mission Logement</th>
                                <td colspan="2">
                                  <input type="datetime-local" id="date_fin" name="date_fin" class="date_fin"
                                    value="${date_fin}" />
                                </td>
                              </tr>
                              <tr>
                                <td></td>
                                <td>
                                  <button class="Enregistrer" formaction="saveConfig.do"
                                    style="background-color:lightgreen; cursor:pointer;">Mettre à jour <img
                                      src="img/save.png" class="icon" /></button>
                                </td>
                                <td>
                                  <button type="button" <c:if test="${missionStatus != 2}">disabled="disabled"</c:if> style="cursor: pointer;" onclick="return checkSubmit('configuration', 'supprimerDonnees.do', '!!Attention!! \n Voulez-vous vraiment supprimer ces données ?\n Cette action est irréversible');" formaction="supprimerDonnees.do" id="supprimerDonnees" class="Supprimer" >SupprimerDonnees <img src="img/warning.png" class="icon"/></button>
                                </td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </form>
                  </div>

                  <c:if test="${missionStatus != 2}">
                    <div class="row">
                      <div class="col-md-12">
                        <hr />
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-12">
                        <div class="alert alert-info">
                          <strong>Structure attendue du fichier CSV :</strong>
                          <pre>
Genre;Nom;Prénom;Date de naissance;Code Postal;Ville;PAYS;NUMERO SCEI;MAIL

Exemple:
M.;Durand;Lucas;15/06/2002;75015;Paris;France;84532;lucas.durand@eleves.ec-nantes.fr
</pre>
                        </div>
                        <form id="importForm" action="importEleves.do" method="POST" enctype="multipart/form-data">
                          <button type="button" class="Import" style="cursor: pointer;"
                            onclick="document.getElementById('fichierImport').click();">
                            Import des dossiers
                            <img src="img/import.png" class="import" />
                          </button>
                          <input type="hidden" name="connexionId" value="${connexionId}" />
                          <input type="file" id="fichierImport" name="file" class="fichierImport" accept="text/.csv"
                            style="display: none;" onchange="document.getElementById('importForm').submit();" />
                        </form>
                      </div>
                    </div>
                  </c:if>

                  <div class="row">
                    <div class="col-md-12">
                      <hr />
                    </div>
                    <form action="#" method="POST" id="configuration">
                      <input type="hidden" name="connexionId" value="${connexionId}" />
                      <div class="col-md-12">
                        <div class="table-responsive">
                          <table class="table table-striped">
                            <tbody>
                              <tr>
                                <td style="background-color:yellow" colspan="3">Statut actuel :
                                  <strong>${missionStatus == 0 ? 'Avant mission' : (missionStatus == 1 ? 'Mission en
                                    cours' : 'Mission fermée')}</strong>
                                </td>
                              </tr>

                              <tr>
                                <th scope="col">Adresse mail de l'envoyeur</th>
                                <td colspan="2">
                                  <input type="text" name="adresse_mail_envoyeur" size="80" class="mail_envoyeur"
                                    value="${adresse_mail_envoyeur}" />
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Mail pour l'authentification</th>
                                <td>
                                  <textarea name="message_contact" class="message_mail" rows="10"
                                    cols="50">${message_contact}</textarea>
                                </td>
                                <td>
                                  <c:if test="${missionStatus == 0}">
                                    <button class="EnvoiMails" formaction="generatetokens.do"
                                      style="cursor: pointer;">Générer token</button>
                                    <button class="EnvoiMails" formaction="envoiemail.do"
                                      style="cursor: pointer;">Envoyer mails <img src="img/mail.png"
                                        class="mails" /></button>
                                  </c:if>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Mail de réinitialisation de password</th>
                                <td>
                                  <textarea name="message_reset_password" class="message_password" rows="10"
                                    cols="50">${message_reset_password}</textarea>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Mail après la fermeture</th>
                                <td>
                                  <textarea name="message_mission_fermee" class="message_fin" rows="10"
                                    cols="50">${message_mission_fermee}</textarea>
                                </td>
                                <td>
                                  <c:if test="${missionStatus == 2}">
                                    <button class="EnvoiMails" formaction="envoiemailfin.do" disabled="disabled">Envoyer
                                      mails <img src="img/mail.png" class="mails" /></button>
                                  </c:if>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Mail de dossier incomplet</th>
                                <td>
                                  <textarea name="message_dossier_incomplet" class="message_dossier_incomplet" rows="10"
                                    cols="50">${message_dossier_incomplet}</textarea>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Mail de dossier complet</th>
                                <td>
                                  <textarea name="message_dossier_complet" class="message_dossier_complet" rows="10"
                                    cols="50">${message_dossier_complet}</textarea>
                                </td>
                              </tr>
                              
                                  

                              <tr>
                                <td></td>
                                <td colspan="2">
                                  <button class="Enregistrer" formaction="saveConfig.do">Sauvegarder <img
                                      src="img/save.png" class="icon" /></button>
                                </td>
                              </tr>

                              <tr>
                                <td colspan="3">
                                  <hr />
                                </td>
                              </tr>
                              <tr>
                                <td style="background-color:yellow" colspan="3">Statut actuel :
                                  <strong>${missionStatus == 0 ? 'Avant mission' : (missionStatus == 1 ? 'Mission en
                                    cours' : 'Mission fermée')}</strong>
                                </td>
                              </tr>

                              <tr>
                                <th scope="col">Message sur la page de connexion (avant mission)</th>
                                <td colspan="2">
                                  <textarea name="message_avant_connexion" class="message_page_connexion" rows="10"
                                    cols="50">${message_avant_connexion}</textarea>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Message sur la page de connexion (mission en cours)</th>
                                <td colspan="2">
                                  <textarea name="message_pge_connexion" class="message_page_connexion" rows="10"
                                    cols="50">${message_pge_connexion}</textarea>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Message sur la page de connexion (mission fermée)</th>
                                <td colspan="2">
                                  <textarea name="message_page_attente" class="message_attente" rows="10"
                                    cols="50">${message_page_attente}</textarea>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Message sur la page d'informations sur la page des candidats</th>
                                <td colspan="2">
                                  <textarea name="message_page_informations" class="message_informations" rows="10"
                                    cols="50">${message_page_informations}</textarea>
                                </td>
                              </tr>

                              <tr>
                                <td colspan="3">
                                  <hr />
                                  <h4 class="text-center">Infobulles du formulaire</h4>
                                </td>
                              </tr>
                              <tr>
                                <th scope="col">Nom</th>
                                <td colspan="2"><textarea name="tooltip_nom" rows="2"
                                    cols="80">${tooltip_nom}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Prénom</th>
                                <td colspan="2"><textarea name="tooltip_prenom" rows="2"
                                    cols="80">${tooltip_prenom}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Date de naissance</th>
                                <td colspan="2"><textarea name="tooltip_date_naissance" rows="2"
                                    cols="80">${tooltip_date_naissance}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Ville</th>
                                <td colspan="2"><textarea name="tooltip_ville" rows="2"
                                    cols="80">${tooltip_ville}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Code Postal</th>
                                <td colspan="2"><textarea name="tooltip_code_postal" rows="2"
                                    cols="80">${tooltip_code_postal}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Pays</th>
                                <td colspan="2"><textarea name="tooltip_pays" rows="2"
                                    cols="80">${tooltip_pays}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Adresse mail</th>
                                <td colspan="2"><textarea name="tooltip_mail" rows="2"
                                    cols="80">${tooltip_mail}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Confirmation mail</th>
                                <td colspan="2"><textarea name="tooltip_confirm_mail" rows="2"
                                    cols="80">${tooltip_confirm_mail}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Genre</th>
                                <td colspan="2"><textarea name="tooltip_genre" rows="2"
                                    cols="80">${tooltip_genre}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Numéro de téléphone</th>
                                <td colspan="2"><textarea name="tooltip_tel" rows="2"
                                    cols="80">${tooltip_tel}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Êtes-vous boursier ?</th>
                                <td colspan="2"><textarea name="tooltip_bourse" rows="2"
                                    cols="80">${tooltip_bourse}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Préférence logement</th>
                                <td colspan="2"><textarea name="tooltip_souhait" rows="2"
                                    cols="80">${tooltip_souhait}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">PMR / Handicap</th>
                                <td colspan="2"><textarea name="tooltip_pmr" rows="2"
                                    cols="80">${tooltip_pmr}</textarea></td>
                              </tr>
                              <tr>
                                <th scope="col">Autres informations</th>
                                <td colspan="2"><textarea name="tooltip_infos" rows="2"
                                    cols="80">${tooltip_infos}</textarea></td>
                              </tr>

                              <tr>
                                <td></td>
                                <td colspan="2">
                                  <button class="Enregistrer" formaction="saveConfig.do">Sauvegarder <img
                                      src="img/save.png" class="icon" /></button>
                                </td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
          </div>
        </body>

        </html>