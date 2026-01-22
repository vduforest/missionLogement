<%-- Document : configuration Created on : 27 janv. 2025, 16:38:56 Author : Amolz --%>
  <%@taglib prefix="c" uri="jakarta.tags.core" %>
    <%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="fr-fr">

        <head>
          <title>CONFIGURATION</title>
          <meta charset="UTF-8" />
          <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
          <link href="css/default.css" type="text/css" rel="stylesheet" />
          <link href="css/configuration.css" type="text/css" rel="stylesheet" />
          <script src="js/configuration.js"></script>
        </head>

        <body>
          <div id="header">
            <nav class="navbar navbar-expand-md navbar-dark bg-dark">
              <div class="container">
                <div class="collapse navbar-collapse" id="navbar1">
                  <form method="POST">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <ul class="navbar-nav ml-auto">
                      <h1>Plateforme Mission Logement</h1>
                      <li class="nav-item"><button class="btn nav-link text-white" formaction="adminDashboard.do"><img
                            src="img/logocn.png" alt="logo" class="logo" /></button></li>
                      <li class="nav-item"><button class="btn nav-link text-white" formaction="index.do"><img
                            src="img/porteOuverte.png" alt="sortie" class="sortie" /></button></li>
                    </ul>
                  </form>
                </div>
              </div>
            </nav>
          </div>

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